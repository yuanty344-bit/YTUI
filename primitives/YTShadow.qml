import QtQuick
import QtQuick.Effects
import "../theme"

Item {

    id: root

    // ── Dynamic elevation — diagonal light (upper-right → lower-left) ──

    property real  shadowHOffset: 2
    property real  shadowVOffset: 4
    property real  shadowBlur:    1.0
    property real  shadowAlpha:   0.45
    property color tintColor:     "#000000"

    Behavior on shadowHOffset {
        NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
    }
    Behavior on shadowVOffset {
        NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
    }
    Behavior on shadowBlur {
        NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
    }
    Behavior on shadowAlpha {
        NumberAnimation { duration: YTAnimation.normal; easing.type: Easing.OutCubic }
    }

    // ── Source ──────────────────────────────────────

    Rectangle {

        id: shadowSource

        anchors.centerIn: parent

        width:  parent.width  - 2
        height: parent.height - 2

        radius:  height / 2
        color:   root.tintColor
        opacity: 0.85
    }

    // ── Blur pass ───────────────────────────────────

    MultiEffect {

        id: shadowFx

        anchors.fill: parent

        source: shadowSource

        shadowEnabled: true

        shadowHorizontalOffset: root.shadowHOffset
        shadowVerticalOffset:   root.shadowVOffset
        shadowBlur:             root.shadowBlur
        shadowOpacity:          root.shadowAlpha
    }
}