import QtQuick
import "../controls"
import "../theme"

Rectangle {

    width:  700
    height: 260

    radius: 20
    color:  "#14FFFFFF"
    border.width: 1
    border.color: "#1AFFFFFF"

    Row {

        anchors.centerIn: parent
        spacing: 40

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text:  "YTToggle"
            color: "white"
            font.pixelSize: 18
            font.weight: Font.DemiBold
        }

        Column {
            spacing: 18
            topPadding: 10

            Row { spacing: 12
                YTToggle { text: "checked: true";  checked: true;  accentColor: YTTheme.accent }
                Text   { text: "hover for glow"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTToggle { text: "checked: false"; checked: false; accentColor: YTColors.blue }
                Text   { text: "click to toggle"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTToggle { text: "enabled: false"; enabled: false }
                Text   { text: "no interaction"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
        }
    }
}