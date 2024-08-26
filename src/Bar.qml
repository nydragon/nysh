import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import Quickshell.Io // for process
import "windows"
import QtQuick.Layouts
import "systray"

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
                Layout.alignment: Qt.AlignTop
            }

            AudioOutput {
                id: audio
                popupAnchor: root
                anchors.top: clock.bottom
                Layout.alignment: Qt.AlignTop
            }

            SysTray {
                anchors.top: audio.bottom
                Layout.alignment: Qt.AlignTop
            }
        }
    }
}
