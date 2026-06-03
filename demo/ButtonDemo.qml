import QtQuick
import "../controls"
import "../theme"

// ═══════════════════════════════════════════════════
// Glass card — wraps the demo
// ═══════════════════════════════════════════════════

Item {

    id: cardWrapper

    width:  560
    height: 680

    // ── Card body ─────────────────────────────────

    Rectangle {

        anchors.fill: parent

        radius: 28

        color:        "#18FFFFFF"
        border.width: 1
        border.color: "#1AFFFFFF"

        // ── Glass specular ─────────────────────────

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
        spacing: 34
        width: 360

        // ── Header ─────────────────────────────────

        Text {

            anchors.horizontalCenter: parent.horizontalCenter

            text: "YTUI Button"
            color: "white"
            font.pixelSize: 26
            font.weight: Font.Bold
        }

        // ── Variant · Primary ──────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {

                text:  "Variant · Primary"
                color: "#66FFFFFF"
                font.pixelSize: 11
                font.weight: Font.Medium
            }

            Item { width: 1; height: 6 }

            YTButton {

                anchors.horizontalCenter: parent.horizontalCenter

                text:        "Play"
                iconSource:  "../assets/icons/play.svg"
                variant:     "primary"
                accentColor: YTTheme.accent
                onClicked:   console.log("Play")
            }
        }

        // ── Variant · Secondary ────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {

                text:  "Variant · Secondary"
                color: "#55FFFFFF"
                font.pixelSize: 11
                font.weight: Font.Medium
            }

            Item { width: 1; height: 6 }

            YTButton {

                anchors.horizontalCenter: parent.horizontalCenter

                text:        "Options"
                iconSource:  "../assets/icons/settings.svg"
                variant:     "secondary"
                accentColor: YTColors.blue
                onClicked:   console.log("Options")
            }
        }

        // ── Variant · Ghost ────────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {

                text:  "Variant · Ghost"
                color: "#44FFFFFF"
                font.pixelSize: 11
                font.weight: Font.Medium
            }

            Item { width: 1; height: 6 }

            YTButton {

                anchors.horizontalCenter: parent.horizontalCenter

                text:        "Exit"
                iconSource:  "../assets/icons/exit.svg"
                variant:     "ghost"
                accentColor: YTColors.purple
                onClicked:   console.log("Exit")
            }
        }

        // ── State · Disabled ───────────────────────

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

            YTButton {

                anchors.horizontalCenter: parent.horizontalCenter

                text:    "Disabled"
                variant: "primary"
                enabled: false
            }
        }

        // ── State · Loading ────────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {

                text:  "State · Loading"
                color: "#44FFFFFF"
                font.pixelSize: 11
                font.weight: Font.Medium
            }

            Item { width: 1; height: 6 }

            YTButton {

                id: loadingBtn

                anchors.horizontalCenter: parent.horizontalCenter

                text:        "Save"
                iconSource:  "../assets/icons/download.svg"
                variant:     "primary"
                accentColor: YTColors.green
                loading:     false

                onClicked: {
                    loadingBtn.loading = true
                    loadingTimer.restart()
                }
            }

            Timer {

                id: loadingTimer
                interval: 1800
                onTriggered: loadingBtn.loading = false
            }
        }
    }
}