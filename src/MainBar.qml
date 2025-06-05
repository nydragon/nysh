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

    Behavior on color {
        ColorAnimation {
            duration: 1000
        }
    }

    NotificationToasts {
        screen: root.screen
        contentX: root.width
    }

    RowLayout {
        id: layout
        height: parent.height

        BRectangle {
            color: Colors.data.colors.dark.surface

            implicitWidth: 35
            Layout.fillHeight: true

            Column {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.topMargin: 2
                Layout.bottomMargin: 2
                Layout.rightMargin: 2
                spacing: 2

                // TODO: on click open a calendar view
                ClockWidget {}

                AudioOutput {
                    width: parent.width
                    height: parent.width * 1.2

                    onClicked: {
                        NyshState.toggleAudio();
                    }
                }

                SysTray {
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Workspaces {}

                Battery {
                    width: 35
                    height: 35
                }

                Caffeine {
                    width: 35
                    height: 35
                }

                Privacy {}

                BMButton {
                    width: 35
                    height: 35
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

        Dashboard {}
    }
}
