pragma Singleton
import QtQuick

QtObject {

    // ── Palette ──────────────────────────────────────

    property color accent:     "#FF66AA"
    property color background: "#2A2A2A"
    property color surface:    "#363636"
    property color text:       "#FFFFFF"

    // ── Elevation tokens ─────────────────────────────
    //  Normal / Hover / Pressed

    readonly property real elevationLift:     0
    readonly property real elevationHover:    -3
    readonly property real elevationPress:    1

    readonly property real shadowBlurNormal:  1.0
    readonly property real shadowBlurHover:   1.4
    readonly property real shadowBlurPress:   0.5

    // Diagonal light — upper-right → lower-left
    readonly property real shadowHOffsetNormal: 2
    readonly property real shadowHOffsetHover:  5
    readonly property real shadowHOffsetPress:  1

    readonly property real shadowVOffsetNormal: 4
    readonly property real shadowVOffsetHover:  9
    readonly property real shadowVOffsetPress:  2

    readonly property real shadowAlphaNormal:  0.35
    readonly property real shadowAlphaHover:   0.55
    readonly property real shadowAlphaPress:   0.18

    // ── Disabled state ──────────────────────────────

    readonly property real  disabledOpacity:     0.42
    readonly property color disabledAccent:      "#666666"
    readonly property color disabledText:        "#888888"

    // Surface gradient tiles when disabled
    readonly property color disabledSurfaceTop:    "#555555"
    readonly property color disabledSurfaceUpper:  "#4A4A4A"
    readonly property color disabledSurfaceCore:   "#3F3F3F"
    readonly property color disabledSurfaceBottom: "#363636"

    // ── Variant tokens ──────────────────────────────
    //  primary / secondary / ghost

    readonly property real variantPrimaryOpacity:   1.0
    readonly property real variantSecondaryOpacity: 0.50
    readonly property real variantGhostOpacity:     0.0

    // ── Loading breathe ─────────────────────────────

    readonly property real breatheScaleMin:  0.965
    readonly property int  breathePulseMs:   500
}