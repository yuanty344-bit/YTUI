import QtQuick
import "../primitives"
import "../theme"

Item {

    id: root

    implicitWidth: 200
    implicitHeight: 60

    width:  implicitWidth
    height: implicitHeight

    // ── Internal geometry ──────────────────────────

    readonly property int surfaceWidth:  width
    readonly property int surfaceHeight: height - 12

    // ── Public API ──────────────────────────────────

    property alias  text:       label.text
    property alias  iconSource: iconImage.source
    property string variant:     "primary"   // "primary" | "secondary" | "ghost"
    property color  accentColor: YTTheme.accent
    property bool   loading:     false

    signal clicked()

    // ── State ───────────────────────────────────────

    readonly property bool interactive: root.enabled && !root.loading
    property bool hovered: mouse.containsMouse && root.interactive
    property bool pressed: mouse.pressed     && root.interactive

    // ═══════════════════════════════════════════════════
    // Visual root — state-driven transform hub
    // ═══════════════════════════════════════════════════

    Item {

        id: visualRoot

        anchors.fill: parent

        opacity: root.enabled ? 1.0 : YTTheme.disabledOpacity
        Behavior on opacity {
            NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
        }

        // ── Elevation lift ─────────────────────────

        y:
            !root.interactive ? YTTheme.elevationLift
            : root.pressed ? YTTheme.elevationPress
            : root.hovered ? YTTheme.elevationHover
            : YTTheme.elevationLift

        scale: (root.pressed && root.interactive) ? 0.96 : 1.0

        // ── Breathing pulse (loading) ─────────────

        SequentialAnimation on scale {

            id: breatheAnim

            running: root.loading
            loops:   Animation.Infinite

            PropertyAnimation {
                from: 1.0
                to:   YTTheme.breatheScaleMin
                duration: YTTheme.breathePulseMs
                easing.type: Easing.InOutCubic
            }
            PropertyAnimation {
                from: YTTheme.breatheScaleMin
                to:   1.0
                duration: YTTheme.breathePulseMs
                easing.type: Easing.InOutCubic
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: root.pressed ? YTAnimation.micro : YTAnimation.normal
                easing.type: Easing.OutQuart     // Gentler than OutBack — breath, not bounce
            }
        }

        Behavior on scale {
            enabled: !root.loading
            NumberAnimation {
                duration: root.pressed ? YTAnimation.micro : YTAnimation.normal
                easing.type: Easing.OutCubic
            }
        }

        // ── Shadow · dynamic elevation ────────────

        YTShadow {

            anchors.centerIn: parent

            width:  root.surfaceWidth
            height: root.surfaceHeight

            z: -2

            shadowHOffset:
                root.pressed ? YTTheme.shadowHOffsetPress
                : root.hovered ? YTTheme.shadowHOffsetHover
                : YTTheme.shadowHOffsetNormal

            shadowVOffset:
                root.pressed ? YTTheme.shadowVOffsetPress
                : root.hovered ? YTTheme.shadowVOffsetHover
                : YTTheme.shadowVOffsetNormal

            shadowBlur:
                root.pressed ? YTTheme.shadowBlurPress
                : root.hovered ? YTTheme.shadowBlurHover
                : YTTheme.shadowBlurNormal

            shadowAlpha:
                root.pressed ? YTTheme.shadowAlphaPress
                : root.hovered ? YTTheme.shadowAlphaHover
                : YTTheme.shadowAlphaNormal
        }

        // ── Surface · variant-driven ──────────────

        YTSurface {

            anchors.centerIn: parent

            width:  root.surfaceWidth
            height: root.surfaceHeight

            accentColor:
                root.enabled ? root.accentColor : YTTheme.disabledAccent

            hovered:  root.hovered
            pressed:  root.pressed
            disabled: !root.enabled
            variant:  root.variant
        }

        // ── Ripple ────────────────────────────────

        YTRipple {

            id: ripple

            anchors.centerIn: parent

            width:  root.surfaceWidth
            height: root.surfaceHeight

            rippleColor:
                root.enabled
                    ? Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.28)
                    : "#00FFFFFF"
        }

        // ── Icon + Label row ──────────────────────

        Row {

            anchors.centerIn: parent
            spacing: 8

            Image {

                id: iconImage

                sourceSize: Qt.size(18, 18)
                fillMode:   Image.PreserveAspectFit
                visible:    source != ""
            }

            Text {

                id: label

                color:
                    root.enabled ? "white" : YTTheme.disabledText

                font.pixelSize: 16
                font.weight:    Font.DemiBold
                visible:        !root.loading
            }
        }
    }

    // ═══════════════════════════════════════════════════
    // Input
    // ═══════════════════════════════════════════════════

    MouseArea {

        id: mouse

        anchors.fill: parent

        hoverEnabled: root.interactive
        cursorShape:  root.interactive ? Qt.PointingHandCursor : Qt.ArrowCursor

        onPressed: {
            if (root.interactive) {
                ripple.start(mouseX, mouseY)
            }
        }

        onClicked: {
            if (root.interactive) {
                root.clicked()
            }
        }
    }
}