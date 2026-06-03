import QtQuick
import "../controls"
import "../theme"

Rectangle {

    width:  700
    height: 250

    radius: 20
    color:  "#14FFFFFF"
    border.width: 1
    border.color: "#1AFFFFFF"

    Row {

        anchors.centerIn: parent
        spacing: 32

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text:  "YTSlider"
            color: "white"
            font.pixelSize: 18
            font.weight: Font.DemiBold
        }

        Column {
            spacing: 14
            YTSlider { width: 500; text: "Normal";       value: 75; accentColor: YTTheme.accent }
            YTSlider { width: 500; text: "Custom color"; value: 40; accentColor: YTColors.blue }
            YTSlider { width: 500; text: "Disabled";     value: 25; enabled: false }
        }
    }
}