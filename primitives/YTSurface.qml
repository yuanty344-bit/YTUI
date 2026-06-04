import QtQuick
import "../theme"

Rectangle {

    id: root

    property color  accentColor: "#FF66AA"
    property bool   hovered:     false
    property bool   pressed:     false
    property bool   disabled:    false
    property string variant:     "primary"   // "primary" | "secondary" | "ghost"

    radius: height / 2

    // ── Variant-driven base opacity ─────────────────

    readonly property real baseAlpha:
        root.variant === "ghost"      ? YTTheme.variantGhostOpacity
        : root.variant === "secondary" ? YTTheme.variantSecondaryOpacity
        : YTTheme.variantPrimaryOpacity

    opacity:
        root.disabled ? 0.38
        : root.pressed ? 0.90
        : root.hovered ? (root.variant === "ghost" ? 0.08 : 1.0)
        : baseAlpha

    Behavior on opacity {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }

    // ── 1. Base gradient ────────────────────────────

    gradient: Gradient {

        // Top catch light
        GradientStop {

            position: 0.0

            color:
                root.disabled
                    ? YTTheme.disabledSurfaceTop
                    : root.pressed
                        ? Qt.darker(root.accentColor, 1.25)
                        : root.hovered
                            ? Qt.lighter(root.accentColor, 1.30)
                            : Qt.lighter(root.accentColor, 1.12)
        }

        // Upper body
        GradientStop {

            position: 0.28

            color:
                root.disabled
                    ? YTTheme.disabledSurfaceUpper
                    : root.pressed
                        ? Qt.darker(root.accentColor, 1.38)
                        : root.hovered
                            ? Qt.lighter(root.accentColor, 1.12)
                            : root.accentColor
        }

        // Core shadow
        GradientStop {

            position: 0.65

            color:
                root.disabled
                    ? YTTheme.disabledSurfaceCore
                    : root.pressed
                        ? Qt.darker(root.accentColor, 1.50)
                        : root.hovered
                            ? root.accentColor
                            : Qt.darker(root.accentColor, 1.08)
        }

        // Bottom bounce light
        GradientStop {

            position: 1.0

            color:
                root.disabled
                    ? YTTheme.disabledSurfaceBottom
                    : root.pressed
                        ? Qt.darker(root.accentColor, 1.55)
                        : root.hovered
                            ? Qt.darker(root.accentColor, 1.02)
                            : Qt.darker(root.accentColor, 1.12)
        }
    }

    border.width: 0

    // ── 2. Glossy specular flash ────────────────────

    Rectangle {

        anchors.fill: parent
        radius: parent.radius

        gradient: Gradient {

            // Highlight peaks slightly inset from top edge — avoids bright rim
            GradientStop { position: 0.0;   color: "#04FFFFFF" }
            GradientStop { position: 0.04;  color: "#14FFFFFF" }
            GradientStop { position: 0.10;  color: "#08FFFFFF" }
            GradientStop { position: 0.20;  color: "#00000000" }
        }

        opacity:
            root.disabled ? 0.0
            : root.pressed ? 0.15
            : root.hovered ? 1.0
            : root.variant === "ghost" ? 0.0
            : 0.35

        Behavior on opacity {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
    }
}