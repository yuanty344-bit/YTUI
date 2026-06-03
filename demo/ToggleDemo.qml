import QtQuick
import "../controls"
import "../theme"

Rectangle {

    width:  700
    height: 150

    radius: 20
    color:  "#14FFFFFF"
    border.width: 1
    border.color: "#1AFFFFFF"

    Row {

        anchors.centerIn: parent
        spacing: 32

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text:  "YTToggle"
            color: "white"
            font.pixelSize: 18
            font.weight: Font.DemiBold
        }

        Column {
            spacing: 8

            Row { spacing: 12
                YTToggle { checked: true; accentColor: YTTheme.accent }
                Text { text: "checked: true"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTToggle { checked: false; accentColor: YTColors.blue }
                Text { text: "checked: false"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
            Row { spacing: 12
                YTToggle { enabled: false }
                Text { text: "enabled: false"; color: "#55FFFFFF"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            }
        }
    }
}