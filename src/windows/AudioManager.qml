pragma Singleton

import Quickshell
import QtQuick

Singleton {
    FloatingWindow {
        color: "transparent"
        height: 300
        width: 600

        Rectangle {
            anchors.fill: parent
            color: "#20ffffff"

            // your content here
        }
    }
}
