import QtQuick
import "../controls"
import "../theme"

Rectangle {

    width:  700
    height: 375

    radius: 20
    color:  "#14FFFFFF"
    border.width: 1
    border.color: "#1AFFFFFF"

    Row {

        anchors.centerIn: parent
        spacing: 32

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text:  "YTButton"
            color: "white"
            font.pixelSize: 18
            font.weight: Font.DemiBold
        }

        Column {
            spacing: 8

            Row { spacing: 12
                YTButton { text: "Play"; variant: "primary"; accentColor: YTTheme.accent; iconSource: "../assets/icons/play.svg" }
                Text { text: "variant: primary"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTButton { text: "Options"; variant: "secondary"; accentColor: YTColors.blue; iconSource: "../assets/icons/settings.svg" }
                Text { text: "variant: secondary"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTButton { text: "Exit"; variant: "ghost"; accentColor: YTColors.purple; iconSource: "../assets/icons/exit.svg" }
                Text { text: "variant: ghost"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTButton { text: "Disabled"; variant: "primary"; enabled: false }
                Text { text: "enabled: false"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTButton {
                    id: bDemo
                    text: "Save"; variant: "primary"; accentColor: YTColors.green
                    iconSource: "../assets/icons/download.svg"
                    onClicked: { bDemo.loading = true; bDemoTimer.restart() }
                }
                Text { text: "loading: true (click)"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                Timer { id: bDemoTimer; interval: 1800; onTriggered: bDemo.loading = false }
            }
        }
    }
}