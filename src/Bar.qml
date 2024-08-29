import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"

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
            margins.top: 2
            margins.bottom: 2

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

                Battery {}
                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }
}
