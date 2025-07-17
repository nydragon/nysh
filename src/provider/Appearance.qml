pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property Rounding rounding: Rounding {}

    component Rounding: QtObject {
        readonly property int small: 12
        readonly property int normal: 17
        readonly property int large: 25
        readonly property int full: 9001
    }
}
