pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property var date: clock.date
    property string time: date.toLocaleString(Qt.locale())

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
