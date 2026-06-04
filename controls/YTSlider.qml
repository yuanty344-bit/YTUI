import QtQuick
import "../theme"

Item {

    id: root

    implicitWidth: 400
    implicitHeight: 64

    width:  implicitWidth
    height: implicitHeight

    // ── Public API ──────────────────────────────────

    property alias  text:        labelText.text
    property real   from:        0.0
    property real   to:          100.0
    property real   value:       50.0
    property string valueSuffix: "%"
    property real   stepSize:    0.0     // 0 = continuous, >0 = discrete steps
    property color  accentColor: YTTheme.accent

    signal moved(real value)

    Accessible.role: Accessible.Slider
    Accessible.name: text || "Slider"

    // ── Internal geometry ──────────────────────────

    readonly property int trackH:   6
    readonly property int thumbR:   10                                     // thumb radius
    readonly property int trackY:   38                                     // track vertical center
    readonly property int thumbY:   trackY + trackH / 2 - thumbR          // thumb centered on track
    readonly property int travel:   width - thumbR * 2
    readonly property int thumbX: {
        var t = (root.value - root.from) / (root.to - root.from)
        return Math.max(0, Math.min(root.travel, t * root.travel))
    }

    // ── State ───────────────────────────────────────

    readonly property bool interactive: root.enabled
    property bool hovered: mouseArea.containsMouse && root.interactive
    property bool pressed: mouseArea.pressed     && root.interactive

    // ═══════════════════════════════════════════════════
    // Label + Value
    // ═══════════════════════════════════════════════════

    Text {

        id: labelText

        anchors.left: parent.left

        color: root.enabled ? "white" : YTTheme.disabledText
        font.pixelSize: 14
        font.weight: Font.Medium
        visible: text !== ""
    }

    Text {

        id: valueText

        anchors.right: parent.right

        y: labelText.y

        text:  Math.round(root.value) + root.valueSuffix
        color: root.enabled
            ? (root.hovered || root.pressed ? root.accentColor : "#66FFFFFF")
            : YTTheme.disabledText
        font.pixelSize: 14
        font.weight: Font.Medium

        Behavior on color {
            ColorAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    // ═══════════════════════════════════════════════════
    // Track
    // ═══════════════════════════════════════════════════

    // Background
    Rectangle {

        y:       root.trackY
        width:   parent.width
        height:  root.trackH

        radius:  height / 2
        color:   "#2A2A2A"

        opacity: root.enabled ? 1.0 : YTTheme.disabledOpacity
        Behavior on opacity {
            NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
        }
    }

    // Fill — extends to thumb center, separate from thumb
    Rectangle {

        y:      root.trackY
        x:      0
        width:  root.thumbX + root.thumbR

        height: root.trackH

        radius:  height / 2
        color:   root.accentColor

        opacity: root.enabled ? 1.0 : YTTheme.disabledOpacity
        Behavior on opacity {
            NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
        }

        Behavior on width {
            enabled: !root.pressed
            NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
        }

        // Glass specular
        Rectangle {

            anchors.fill: parent
            radius: parent.radius

            gradient: Gradient {
                GradientStop { position: 0.0;  color: "#12FFFFFF" }
                GradientStop { position: 0.35; color: "#04FFFFFF" }
                GradientStop { position: 1.0;  color: "#00000000" }
            }
        }
    }

    // ═══════════════════════════════════════════════════
    // Thumb — glow + shadow + surface
    // ═══════════════════════════════════════════════════

    // Energy glow — two-layer soft halo
    Rectangle {

        id: glowOuter

        x:      root.thumbX + root.thumbR - width / 2
        y:      root.thumbY + root.thumbR - height / 2

        width:  thumbR * 2 + 22
        height: thumbR * 2 + 22

        radius: width / 2

        color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b,
            root.pressed ? 0.10 : root.hovered ? 0.06 : 0.0)

        Behavior on color {
            ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
        }

        Rectangle {

            anchors.centerIn: parent

            width:  thumbR * 2 + 8
            height: thumbR * 2 + 8

            radius: width / 2

            color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b,
                root.pressed ? 0.22 : root.hovered ? 0.14 : 0.0)

            Behavior on color {
                ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
            }
        }
    }

    // Shadow — beneath thumb, lifts on hover
    Rectangle {

        id: thumbShadow

        x:      root.thumbX + root.thumbR - width / 2
        y:      root.thumbY + root.thumbR - height / 2 + (root.hovered ? 4 : 1)

        width:  thumbR * 2
        height: thumbR * 2

        radius: width / 2
        color:  "#000000"

        opacity: root.pressed ? 0.05 : root.hovered ? 0.15 : 0.08

        Behavior on opacity {
            NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
        }

        Behavior on y {
            NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
        }
    }

    // Thumb surface
    Rectangle {

        id: thumb

        x:      root.thumbX + root.thumbR - width / 2
        y:      root.thumbY

        width:  thumbR * 2
        height: thumbR * 2

        radius: width / 2

        color:
            root.pressed ? Qt.darker(root.accentColor, 1.3)
            : "white"

        scale:
            root.pressed ? 0.88
            : root.hovered ? 1.08
            : 1.0

        Behavior on color {
            ColorAnimation { duration: 150; easing.type: Easing.OutCubic }
        }

        Behavior on x {
            enabled: !root.pressed
            NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
        }

        Behavior on scale {
            NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
        }
    }

    // ═══════════════════════════════════════════════════
    // Input
    // ═══════════════════════════════════════════════════

    MouseArea {

        id: mouseArea

        anchors.fill: parent

        hoverEnabled: root.interactive
        cursorShape:  root.interactive ? Qt.PointingHandCursor : Qt.ArrowCursor

        onPressed: {
            if (!root.interactive) return
            updateValue(mouseX)
        }

        onPositionChanged: {
            if (mouseArea.pressed && root.interactive) {
                updateValue(mouseX)
            }
        }

        function updateValue(mx) {
            var t = Math.max(0, Math.min(1, (mx - root.thumbR) / root.travel))
            var v = root.from + t * (root.to - root.from)
            if (root.stepSize > 0) {
                v = Math.round(v / root.stepSize) * root.stepSize
            }
            root.value = v
            root.moved(root.value)
        }
    }
}