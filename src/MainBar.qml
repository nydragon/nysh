import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"
import "widgets/network"
import "widgets/caffeine"
import "windows/notificationtoast"
import "base"
import "provider"
import Quickshell
import Quickshell.Widgets
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

    width: 40
    color: "transparent"

    NotificationToasts {
        screen: lbar.screen
    }

    Rectangle {
        color: "transparent"
        anchors.alignWhenCentered: true
        anchors.centerIn: parent

        height: parent.height
        width: parent.width

        ColumnLayout {
            width: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Layout.maximumWidth: 30

            // TODO: on click open a calendar view
            ClockWidget {}

            AudioOutput {
                width: parent.width
                height: parent.width * 1.2
            }

            SysTray {}

            Workspaces {}

            Battery {}

            Network {
                width: parent.width
                height: parent.width
            }

            Caffeine {
                width: parent.width
                height: parent.width
            }
        }

        BButton {
            id: mouse
            onClicked: NyshState.toggleDash()

            IconImage {
                source: {
                    if (NyshState.dndOn)
                        Quickshell.iconPath("notifications-disabled");
                    else if (Notifications.list.values.length)
                        Quickshell.iconPath("notification-active-symbolic");
                    else
                        Quickshell.iconPath("notification-inactive-symbolic");
                }
                anchors.margins: 2
                anchors.fill: parent
            }

            anchors.horizontalCenter: parent.horizontalCenter

            height: width
            width: 30
            anchors.bottom: parent.bottom
        }
    }
}
