import QtQuick
import QtQuick.Window

import "demo"
import "primitives"
import "theme"

Window {

    id: win

    visible: true
    width:  1200
    height: 800
    color:  YTTheme.background

    // ── Background gradient + dither ────────────────

    Rectangle {

        id: bg

        anchors.fill: parent

        gradient: Gradient {

            GradientStop { position: 0.00; color: "#3B3D41" }
            GradientStop { position: 0.10; color: "#38393D" }
            GradientStop { position: 0.22; color: "#343538" }
            GradientStop { position: 0.36; color: "#303133" }
            GradientStop { position: 0.52; color: "#2C2D2F" }
            GradientStop { position: 0.68; color: "#28292A" }
            GradientStop { position: 0.82; color: "#232425" }
            GradientStop { position: 1.00; color: "#1A1B1C" }
        }

        YTNoise {

            anchors.fill: parent
            strength: 0.8
        }
    }

    // ── Demo cards ─────────────────────────────────

    Column {

        anchors.centerIn: parent
        spacing: 20

        ButtonDemo {}
        ToggleDemo {}
        SliderDemo {}
    }
}