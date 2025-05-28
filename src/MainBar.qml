import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"
import "widgets/caffeine"
import "widgets/mpris"
import "widgets/notifications"
import "widgets/privacy"
import "widgets"
import "windows/notificationtoast"
import "widgets/audio"
import "base"
import "provider"
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: lbar

    anchors {
        top: true
        left: true
        bottom: true
    }

    readonly property int baseWidth: 35
    readonly property int expandedWidth: 400

    implicitWidth: layout.implicitWidth
    exclusiveZone: implicitWidth
    color: Colors.data.colors.dark.surface
    focusable: true

    Behavior on color {
        ColorAnimation {
            duration: 1000
        }
    }

    NotificationToasts {
        screen: lbar.screen
        contentX: lbar.width
    }

    RowLayout {
        id: layout
        height: parent.height

        ColumnLayout {
            id: rect
            visible: NyshState.dashOpen
            Layout.preferredWidth: visible ? lbar.expandedWidth : 0
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop
            Layout.margins: 10

            MprisSmall {
                Layout.preferredHeight: 150
                Layout.fillWidth: true
            }

            BSection {
                id: audioSection
                open: NyshState.audioOpen
                Layout.fillWidth: true
                text: "Audio"
                Sinks {
                    id: sink
                    Layout.fillWidth: true
                    visible: audioSection.open
                }
            }

            BSection {
                id: clipboardSection
                Layout.fillWidth: true
                text: "Clipboard"

                Clipboard {
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    visible: parent.open
                }
            }

            NotificationInbox {
                Layout.preferredHeight: 1000
                Layout.fillWidth: true
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

                onClicked: {
                    NyshState.toggleAudio();
                }
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

            Privacy {}

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
