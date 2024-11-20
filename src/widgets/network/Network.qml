import "../../base"
import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import Quickshell

BButton {
    IconImage {
        anchors.fill: parent
        anchors.margins: 2
        source: Quickshell.iconPath("wifi-radar")
    }

    onClicked: () => {
        gui.running = !gui.running;
    }

    Process {
        id: gui
        running: false
        command: ["foot", "nmtui"]
        stdout: SplitParser {
            onRead: data => console.log(`line read: ${data}`)
        }
    }
}
