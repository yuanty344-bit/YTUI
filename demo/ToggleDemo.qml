import QtQuick
import "../controls"
import "../theme"

// ═══════════════════════════════════════════════════
// Glass card — wraps the demo
// ═══════════════════════════════════════════════════

Item {

    id: cardWrapper

    width:  460
    height: 420

    // ── Card body ─────────────────────────────────

    Rectangle {

        anchors.fill: parent

        radius: 28

        color:        "#18FFFFFF"
        border.width: 1
        border.color: "#1AFFFFFF"

        Rectangle {

            anchors.fill: parent
            radius: parent.radius

            gradient: Gradient {

                GradientStop { position: 0.0;   color: "#0CFFFFFF" }
                GradientStop { position: 0.03;  color: "#06FFFFFF" }
                GradientStop { position: 0.08;  color: "#00000000" }
            }
        }
    }

    // ═══════════════════════════════════════════════════
    // Content
    // ═══════════════════════════════════════════════════

    Column {

        anchors.centerIn: parent
        spacing: 36
        width: 380

        // ── Header ─────────────────────────────────

        Text {

            anchors.horizontalCenter: parent.horizontalCenter

            text: "YTUI Toggle"
            color: "white"
            font.pixelSize: 26
            font.weight: Font.Bold
        }

        // ── Basic ──────────────────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {

                text:  "Basic"
                color: "#66FFFFFF"
                font.pixelSize: 11
                font.weight: Font.Medium
            }

            Item { width: 1; height: 6 }

            Row {

                spacing: 40

                YTToggle {

                    id: toggle1

                    accentColor: YTColors.blue
                    onToggled: console.log("Toggle:", toggle1.checked)
                }

                Text {

                    anchors.verticalCenter: parent.verticalCenter
                    text:    toggle1.checked ? "ON" : "OFF"
                    color:   toggle1.checked ? YTColors.blue : "#66FFFFFF"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                }
            }
        }

        // ── Accent colors ──────────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {

                text:  "Colors"
                color: "#55FFFFFF"
                font.pixelSize: 11
                font.weight: Font.Medium
            }

            Item { width: 1; height: 6 }

            Row {

                spacing: 16

                YTToggle { accentColor: YTTheme.accent; checked: true }
                YTToggle { accentColor: YTColors.blue; checked: true }
                YTToggle { accentColor: YTColors.purple; checked: true }
                YTToggle { accentColor: YTColors.green; checked: true }
            }
        }

        // ── Disabled ───────────────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {

                text:  "State · Disabled"
                color: "#44FFFFFF"
                font.pixelSize: 11
                font.weight: Font.Medium
            }

            Item { width: 1; height: 6 }

            Row {

                spacing: 16

                YTToggle { enabled: false; checked: false }
                YTToggle { enabled: false; checked: true }
            }
        }
    }
}