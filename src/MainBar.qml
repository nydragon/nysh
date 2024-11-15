import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"
import "widgets/network"
import "widgets/notifcenter"
import "widgets/caffeine"
import "windows/notificationtoast"
import "windows/workspace-view"
import "base"
import "provider"
import Quickshell // for ShellRoot and PanelWindow
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: lbar

    anchors {
        top: true
        left: Config.alignment === Config.BarAlignment.Left
        right: Config.alignment === Config.BarAlignment.Right
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

    Rectangle {
        color: "transparent"
        anchors.margins: 5

        height: parent.height
        width: parent.width

        ColumnLayout {
            width: 30
            Layout.maximumWidth: 30

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

        MouseArea {
            id: mouse
            onClicked: NyshState.toggleDash()
            height: width
            width: 30
            anchors.bottom: parent.bottom
            cursorShape: Qt.PointingHandCursor
            BRectangle {
                anchors.fill: parent
                Rectangle {
                    visible: mouse.containsMouse
                    anchors.fill: parent
                    radius: parent.radius
                    color: "#9F9F9FC8"
                }
            }
        }
    }
}
