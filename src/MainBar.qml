import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"
import "widgets/caffeine"
import "widgets/privacy"
import "widgets/audio"
import "base"
import "provider"
import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    id: root
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: Config.data.sizes.barWidth
            exclusiveZone: Config.data.sizes.barWidth
            color: "transparent"
            focusable: true
            aboveWindows: true

            RowLayout {
                anchors.fill: parent

                BRectangle {
                    color: Colors.data.colors.dark.surface
                    Layout.fillWidth: true
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
                            id: dashboardButton
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

                            Connections {
                                target: NyshState
                                function onDashOpenChanged() {
                                    dashboardButton.active = NyshState.dashOpen;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
