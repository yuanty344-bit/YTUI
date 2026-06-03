pragma Singleton
import QtQuick

QtObject {

    // ── Duration tokens ──────────────────────────────

    readonly property int instant: 60
    readonly property int micro:   100
    readonly property int fast:    150
    readonly property int normal:  200
    readonly property int slow:    280
    readonly property int relaxed: 400
    readonly property int ripple:  520

}