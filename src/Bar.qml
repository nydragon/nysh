import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import Quickshell.Io // for process
import "windows"
import QtQuick.Layouts
import "widgets/systray"
import "widgets/workspaces"

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

            ColumnLayout {
                anchors.fill: parent

                // TODO: on click open a calendar view
                ClockWidget {}

                AudioOutput {
                    popupAnchor: root
                }

                SysTray {}

                Workspaces {}

                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }
}
