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

    property color colourMain: "#BD93F9"
}
