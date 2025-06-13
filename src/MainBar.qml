import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"
import "widgets/caffeine"
import "widgets/privacy"
import "windows/notificationtoast"
import "widgets/audio"
import "base"
import "provider"
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        bottom: true
    }

    readonly property int baseWidth: 35
    readonly property int expandedWidth: 400

    implicitWidth: layout.implicitWidth
    exclusiveZone: baseWidth // implicitWidth
    color: "transparent"
    focusable: true
    aboveWindows: true

    NotificationToasts {
        screen: root.screen
        contentX: root.width
    }

    RowLayout {
        id: layout
        anchors.fill: parent

        BRectangle {
            color: Colors.data.colors.dark.surface
            implicitWidth: 35
            Layout.fillHeight: true
            topLeftRadius: 0
            bottomLeftRadius: 0

            Column {
                anchors.fill: parent
                anchors.margins: 1
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 2

                // TODO: on click open a calendar view
                ClockWidget {}

                AudioOutput {
                    width: parent.width
                    height: width * 1.2

                    onClicked: {
                        NyshState.toggleAudio();
                    }
                }

                SysTray {
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Workspaces {}

                Battery {
                    width: parent.width
                    height: width
                }

                Caffeine {
                    width: parent.width
                    height: width
                }

                Privacy {}

                BMButton {
                    width: parent.width
                    height: width
                    text: {
                        if (NyshState.dndOn)
                            "󰂛";
                        else if (Notifications.list.values.length)
                            "󱅫";
                        else
                            "󰂚";
                    }
                    toggleable: true
                    onClicked: NyshState.toggleDash()
                    Component.onCompleted: NyshState.dashOpenChanged.connect(() => active = NyshState.dashOpen)
                }
            }
        }
    }
}
