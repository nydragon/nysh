import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import Quickshell.Io // for process

Scope {
    Variants {
        model: Quickshell.screens
        // the screen from the screens list will be injected into this property
        PanelWindow {
            property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                bottom: true
            }

            width: 30

            // the ClockWidget type we just created
            // TODO: on click open a calendar view
            ClockWidget {
                id: clock
                anchors.horizontalCenter: parent.horizontalCenter
            }

            AudioOutput {
                anchors.top: clock.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
