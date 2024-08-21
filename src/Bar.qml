import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import Quickshell.Io // for process

Scope {
    Variants {
        model : Quickshell.screens
            // the screen from the screens list will be injected into this property
        PanelWindow {
            property var modelData
            screen: modelData
            anchors {
                top : true
                left : true
                bottom : true
            }
            width : 20

             // the ClockWidget type we just created
            ClockWidget {
                anchors.centerIn: parent
            }
        }
    }
}
