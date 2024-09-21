import "root:base"
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick

BRectangle {
    MouseArea {
        anchors.fill: parent

        IconImage {
            anchors.fill: parent
            anchors.margins: 2
            source: Quickshell.iconPath("notification-active")
        }

        onClicked: () => {
            gui.running = true;
        }

        Process {
            id: gui
            running: false
            command: ["swaync-client", "-t"]
        }
    }
}
