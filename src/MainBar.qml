import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"
import "widgets/caffeine"
import "widgets/mpris"
import "windows/notificationtoast"
import "base"
import "provider"
import Quickshell
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

    readonly property int baseWidth: 35
    readonly property int expandedWidth: 400

    implicitWidth: layout.implicitWidth
    exclusiveZone: implicitWidth
    color: Colors.data.colors.dark.surface

    Behavior on color {
        ColorAnimation {
            duration: 1000
        }
    }

    NotificationToasts {
        screen: lbar.screen
    }

    RowLayout {
        id: layout
        height: parent.height

        Column {
            id: rect
            visible: NyshState.dashOpen
            Layout.preferredWidth: visible ? lbar.expandedWidth : 0
            Layout.fillHeight: true
            BSlider {
                width: parent.width
                height: 30
                Layout.preferredHeight: 30
            }

            MprisSmall {
                height: 150
                //Layout.fillWidth: true
                width: parent.width
            }
        }

        Column {
            Layout.preferredWidth: 35
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
            }

            SysTray {}

            Workspaces {}

            Battery {
                width: 35
                height: 35
            }

            Caffeine {
                width: 35
                height: 35
            }

            BButton {
                id: mouse
                onClicked: NyshState.toggleDash()

                BText {
                    text: {
                        if (NyshState.dndOn)
                            "󰂛";
                        else if (Notifications.list.values.length)
                            "󱅫";
                        else
                            "󰂚";
                    }

                    fontSizeMode: Text.Fit
                    height: parent.height
                    width: parent.width
                    Layout.alignment: Qt.AlignCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 720
                }

                width: parent.width
                height: width
            }
        }
    }
}
