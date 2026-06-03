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

    property bool  checked:     false
    property color accentColor: YTTheme.accent

    signal toggled(bool checked)

    // ── Internal geometry ──────────────────────────

    readonly property int knobSize: height - 6
    readonly property int knobRestX:   3
    readonly property int knobOnX:     width - knobSize - 3

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
            width:  root.width
            height: root.height
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

            anchors.fill: parent
            radius: height / 2

            color:
                !root.enabled ? YTTheme.disabledSurfaceCore
                : root.checked
                    ? root.accentColor
                    : "#363636"

            Behavior on color {
                ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
            }

            // Glass specular — matches YTButton surface
            Rectangle {

                anchors.fill: parent
                radius: parent.radius

                gradient: Gradient {
                    GradientStop { position: 0.0;  color: "#0CFFFFFF" }
                    GradientStop { position: 0.08; color: "#04FFFFFF" }
                    GradientStop { position: 0.30; color: "#00000000" }
                }

                opacity: root.checked ? 0.6 : 0.0
                Behavior on opacity {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }
            }
        }

        // ── Knob glow — thin ring on hover ────────

        Rectangle {

            anchors.centerIn: knob

            width:  knob.width + 7
            height: knob.height + 7

            radius:       width / 2
            color:        "transparent"
            border.width: 1.5
            border.color: root.accentColor

            opacity: root.hovered ? 0.22 : 0.0
            z: -1

            scale: knob.scale

            Behavior on opacity {
                NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
            }
        }

        // ── Knob ──────────────────────────────────

        Rectangle {

            id: knob

            width:  root.knobSize
            height: root.knobSize

            y: 3
            radius: width / 2
            color:  "white"

            // Subtle rim on hover
            border.width: root.hovered ? 1 : 0
            border.color: "#22FFFFFF"

            x: root.checked ? root.knobOnX : root.knobRestX

            Behavior on x {
                NumberAnimation {
                    duration: 260
                    easing.type: Easing.OutBack
                }
            }

            Behavior on border.width {
                NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
            }

            // Thumb motion feedback (not ripple)
            scale:
                root.pressed ? 0.94
                : root.hovered ? 1.08
                : 1.0

            Behavior on scale {
                NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
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

        onClicked: {
            if (root.interactive) {
                root.checked = !root.checked
                root.toggled(root.checked)
            }
        }
    }
}