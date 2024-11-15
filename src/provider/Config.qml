pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: config
    property Item notifications: Item {
        property int toastDuration: 5000
    }

    enum BarAlignment {
        Left,
        Right
    }

    property int alignment: Config.BarAlignment.Left

    property Item colours: Item {
        property color main: "#BD93F9"
    }
}
