import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import "widgets/systray"
import "widgets/workspaces"
import "widgets/privacy"
import "widgets/battery"
import "widgets/network"
import "widgets/notifcenter"
import "widgets/caffeine"
import "windows/notificationtoast"
import "windows/workspace-view"

Scope {
    Variants {
        model: Quickshell.screens
        // the screen from the screens list will be injected into this property
        PanelWindow {
            id: lbar
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
            NotificationToasts {
                win: lbar
            }

            WorkspaceView {}

            ColumnLayout {
                anchors.fill: parent

                // TODO: on click open a calendar view
                ClockWidget {}

                AudioOutput {}

                SysTray {}

                Workspaces {}

                Battery {}

                //Privacy {}

                Network {}

                Notifcenter {}

                Caffeine {}

                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }
}
