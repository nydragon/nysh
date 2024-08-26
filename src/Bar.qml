import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import Quickshell.Io // for process
import "windows"

Scope {
    Variants {
        model: Quickshell.screens
        // the screen from the screens list will be injected into this property
        PanelWindow {
            id: root
            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                bottom: true
            }
            margins.left: 2

            width: 30
            color: "transparent"

            // the ClockWidget type we just created
            // TODO: on click open a calendar view
            ClockWidget {
                id: clock
                anchors.horizontalCenter: parent.horizontalCenter
            }

            AudioOutput {
                popupAnchor: root
                anchors.top: clock.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
