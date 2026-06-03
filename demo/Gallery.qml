import QtQuick
import QtQuick.Controls
import "../controls"
import "../theme"

Flickable {

    id: gallery

    anchors.fill: parent

    contentWidth:  gallery.width
    contentHeight: column.height

    ScrollBar.vertical: ScrollBar {}

    Column {

        id: column

        anchors.horizontalCenter: parent.horizontalCenter

        width:      660
        spacing:    40
        topPadding: 50
        bottomPadding: 50

        // ── Header ─────────────────────────────────

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  "YTUI Gallery"
                color: "white"
                font.pixelSize: 30
                font.weight: Font.Bold
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  "Qt 6 QML Components"
                color: "#66FFFFFF"
                font.pixelSize: 14
            }
        }

        // ═══════════════════════════════════════════════
        // YTButton
        // ═══════════════════════════════════════════════

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 18

            Text {
                text:  "YTButton"
                color: "white"
                font.pixelSize: 20
                font.weight: Font.DemiBold
            }

            // ── Variants ──────────────────────────

            Column {

                spacing: 6

                Text { text: "Variants"; color: "#55FFFFFF"; font.pixelSize: 11 }

                Row {
                    spacing: 12

                    YTButton { text: "Primary";   variant: "primary";   accentColor: YTTheme.accent; iconSource: "../assets/icons/play.svg" }
                    YTButton { text: "Secondary"; variant: "secondary"; accentColor: YTColors.blue;  iconSource: "../assets/icons/settings.svg" }
                    YTButton { text: "Ghost";     variant: "ghost";     accentColor: YTColors.purple; iconSource: "../assets/icons/exit.svg" }
                }
            }

            // ── States ───────────────────────────

            Column {

                spacing: 6

                Text { text: "States"; color: "#55FFFFFF"; font.pixelSize: 11 }

                Row {
                    spacing: 12

                    YTButton { text: "Disabled"; variant: "primary"; enabled: false }

                    YTButton {
                        id: gLoadingBtn
                        text: "Save"; variant: "primary"; accentColor: YTColors.green
                        iconSource: "../assets/icons/download.svg"
                        onClicked: { gLoadingBtn.loading = true; gLoadingTimer.restart() }
                    }
                    Timer { id: gLoadingTimer; interval: 1800; onTriggered: gLoadingBtn.loading = false }
                }
            }

            // ── All colors ────────────────────────

            Column {

                spacing: 6

                Text { text: "Colors"; color: "#55FFFFFF"; font.pixelSize: 11 }

                Row {
                    spacing: 8
                    YTButton { text: "Pink";   accentColor: YTTheme.accent }
                    YTButton { text: "Blue";   accentColor: YTColors.blue }
                    YTButton { text: "Purple"; accentColor: YTColors.purple }
                    YTButton { text: "Green";  accentColor: YTColors.green }
                    YTButton { text: "Orange"; accentColor: YTColors.orange }
                    YTButton { text: "Cyan";   accentColor: YTColors.cyan }
                }
            }

            // ── With icon ────────────────────────

            Column {

                spacing: 6

                Text { text: "Icons"; color: "#55FFFFFF"; font.pixelSize: 11 }

                Row {
                    spacing: 12
                    YTButton { text: "Play";  variant: "primary"; accentColor: YTTheme.accent; iconSource: "../assets/icons/play.svg" }
                    YTButton { text: "Conf";  variant: "primary"; accentColor: YTColors.blue;  iconSource: "../assets/icons/settings.svg" }
                    YTButton { text: "Exit";  variant: "ghost";   accentColor: YTColors.purple; iconSource: "../assets/icons/exit.svg" }
                    YTButton { text: "Save";  variant: "primary"; accentColor: YTColors.green;  iconSource: "../assets/icons/download.svg" }
                }
            }
        }

        // ═══════════════════════════════════════════════
        // YTToggle
        // ═══════════════════════════════════════════════

        Column {

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 18

            Text {
                text:  "YTToggle"
                color: "white"
                font.pixelSize: 20
                font.weight: Font.DemiBold
            }

            // ── ON — all colors ───────────────────

            Column {

                spacing: 6

                Text { text: "ON · all colors"; color: "#55FFFFFF"; font.pixelSize: 11 }

                Row {
                    spacing: 10
                    YTToggle { checked: true; accentColor: YTTheme.accent }
                    YTToggle { checked: true; accentColor: YTColors.blue }
                    YTToggle { checked: true; accentColor: YTColors.purple }
                    YTToggle { checked: true; accentColor: YTColors.green }
                    YTToggle { checked: true; accentColor: YTColors.orange }
                    YTToggle { checked: true; accentColor: YTColors.cyan }
                }
            }

            // ── OFF — all colors ──────────────────

            Column {

                spacing: 6

                Text { text: "OFF · all colors"; color: "#55FFFFFF"; font.pixelSize: 11 }

                Row {
                    spacing: 10
                    YTToggle { checked: false; accentColor: YTTheme.accent }
                    YTToggle { checked: false; accentColor: YTColors.blue }
                    YTToggle { checked: false; accentColor: YTColors.purple }
                    YTToggle { checked: false; accentColor: YTColors.green }
                    YTToggle { checked: false; accentColor: YTColors.orange }
                    YTToggle { checked: false; accentColor: YTColors.cyan }
                }
            }

            // ── Disabled ──────────────────────────

            Column {

                spacing: 6

                Text { text: "Disabled"; color: "#55FFFFFF"; font.pixelSize: 11 }

                Row {
                    spacing: 10
                    YTToggle { enabled: false; checked: false }
                    YTToggle { enabled: false; checked: true }
                }
            }
        }
    }
}