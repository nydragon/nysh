import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import "widgets/systray"
import "widgets/workspaces"
import "widgets/battery"
import "widgets/network"
import "widgets/notifcenter"
import "widgets/caffeine"
import "windows/notificationtoast"
import "windows/workspace-view"
import "base"
import QtQuick.Controls
import Quickshell.Io

Scope {
    Variants {
        model: Quickshell.screens
    }

    Variants {
        model: Quickshell.screens
        delegate: Item {
            id: root

            property var modelData
            property bool enabled: false

            PanelWindow {
                id: lbar
                screen: root.modelData

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
                        onClicked: () => root.enabled = !root.enabled
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

            PanelWindow {
                id: homeWindow

                property bool animRunning: false

                screen: root.modelData

                IpcHandler {
                    target: "dash"

                    function toggle() {
                        root.enabled = !root.enabled;
                    }
                }

                color: "transparent"
                anchors {
                    top: true
                    left: true
                    bottom: true
                    right: true
                }

                visible: animRunning || root.enabled
                focusable: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: () => root.enabled = false

                    BRectangle {
                        id: home

                        property var maxSize: 0

                        bottomRightRadius: 10
                        topRightRadius: 10
                        border.color: "transparent"
                        height: parent.height
                        width: root.enabled ? maxSize : 0

                        MouseArea {
                            anchors.fill: parent
                        }

                        Component.onCompleted: () => maxSize = homeWindow.screen.width * (2 / 7)

                        Behavior on width {
                            PropertyAnimation {
                                id: anim
                                duration: 100
                                Component.onCompleted: () => {
                                    homeWindow.animRunning = Qt.binding(() => anim.running);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
