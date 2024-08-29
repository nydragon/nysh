pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property var date: new Date()
    property string time: date.toLocaleString(Qt.locale())

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            parent.date = new Date();
        }
    }
}
