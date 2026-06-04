import QtQuick

Rectangle {

    id: root

    // Pill-shaped clip via Rectangle radius
    clip:   true
    color:  "transparent"
    radius: height / 2

    property color rippleColor: "#44FFFFFF"

    // ── Ripple trigger ──────────────────────────────

    function start(xPos, yPos) {

        ripple.x = xPos - ripple.width  / 2
        ripple.y = yPos - ripple.height / 2

        ripple.opacity = 0.32
        ripple.scale   = 0.0

        anim.restart()
    }

    // ── Ripple disc ─────────────────────────────────

    Rectangle {

        id: ripple

        width:  Math.max(root.width, root.height) * 5
        height: Math.max(root.width, root.height) * 5

        radius:  width / 2
        color:   root.rippleColor

        opacity: 0
        scale:   0
    }

    // ── Animation — OutQuint for snap-then-settle ────

    ParallelAnimation {

        id: anim

        NumberAnimation {
            target:     ripple
            property:   "scale"
            from:       0
            to:         1.3
            duration:   500
            easing.type: Easing.OutQuint
        }

        NumberAnimation {
            target:     ripple
            property:   "opacity"
            from:       0.32
            to:         0
            duration:   500
            easing.type: Easing.OutQuint
        }
    }
}