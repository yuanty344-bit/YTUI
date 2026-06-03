import QtQuick
import "../primitives"
import "../theme"

Item {

    id: root

    implicitWidth: 56
    implicitHeight: 28

    width:  implicitWidth
    height: implicitHeight

    // ── Public API ──────────────────────────────────

    property bool   checked:     false
    property string variant:     "primary"
    property color  accentColor: YTTheme.accent

    signal toggled(bool checked)

    // ── Internal geometry ──────────────────────────

    readonly property int trackWidth:  width
    readonly property int trackHeight: height
    readonly property int knobSize:    height - 6          // 22
    readonly property int knobRestX:   3                    // left gap
    readonly property int knobOnX:     width - knobSize - 3 // right gap

    // ── State ───────────────────────────────────────

    readonly property bool interactive: root.enabled
    property bool hovered: mouse.containsMouse && root.interactive
    property bool pressed: mouse.pressed     && root.interactive

    // ═══════════════════════════════════════════════════
    // Visual root
    // ═══════════════════════════════════════════════════

    Item {

        id: visualRoot

        anchors.fill: parent

        opacity: root.enabled ? 1.0 : YTTheme.disabledOpacity
        Behavior on opacity {
            NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
        }

        // ── Elevation ──────────────────────────────

        y:
            root.pressed ? YTTheme.elevationPress
            : root.hovered ? YTTheme.elevationHover
            : YTTheme.elevationLift

        scale: root.pressed ? 0.96 : 1.0

        Behavior on y {
            NumberAnimation {
                duration: root.pressed ? YTAnimation.micro : YTAnimation.normal
                easing.type: Easing.OutQuart
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: root.pressed ? YTAnimation.micro : YTAnimation.normal
                easing.type: Easing.OutCubic
            }
        }

        // ── Shadow ─────────────────────────────────

        YTShadow {

            anchors.centerIn: parent
            width:  root.trackWidth
            height: root.trackHeight
            z: -1

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

        // ── Track ─────────────────────────────────

        Rectangle {

            id: track

            anchors.fill: parent
            radius: height / 2

            // Track color — accent when on, gray when off
            color:
                !root.enabled ? YTTheme.disabledSurfaceCore
                : root.checked
                    ? root.accentColor
                    : Qt.darker(YTTheme.disabledSurfaceUpper, 1.1)

            Behavior on color {
                ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
            }
        }

        // ── Knob ──────────────────────────────────

        Rectangle {

            id: knob

            width:  root.knobSize
            height: root.knobSize

            y: 3                          // centered vertically
            radius: width / 2
            color:  "white"

            x: root.checked ? root.knobOnX : root.knobRestX

            Behavior on x {
                NumberAnimation {
                    duration: 220
                    easing.type: Easing.OutBack
                }
            }

        }

        // ── Ripple ────────────────────────────────

        YTRipple {

            id: ripple

            anchors.centerIn: parent
            width:  root.trackWidth
            height: root.trackHeight

            rippleColor: Qt.rgba(
                root.accentColor.r,
                root.accentColor.g,
                root.accentColor.b,
                0.25
            )
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
                root.checked = !root.checked
                root.toggled(root.checked)
            }
        }
    }
}