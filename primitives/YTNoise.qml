import QtQuick

Item {

    id: root

    // Opacity multiplier
    property real strength: 1.0

    opacity: root.strength

    // ── Tiled noise texture — breaks gradient banding ──

    Image {

        anchors.fill: parent

        source:   "../assets/noise.png"
        fillMode: Image.Tile
    }
}