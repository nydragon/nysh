import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml
import "base"
import "widgets/mpris"
import "widgets/notifications"
import "widgets/weather"
import "widgets/wifi"
import "provider"

PanelWindow {
    id: homeWindow

    property bool animRunning: false
    required property bool focused
    property bool focusLocked: false

    color: "transparent"
    visible: (animRunning || NyshState.dashOpen) && focusLocked

    Component.onCompleted: NyshState.dashOpenChanged.connect(() => {
        if (NyshState.dashOpen)
            focusLocked = focused;
    })

    focusable: true

    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }

    MouseArea {
        id: mouse

        anchors.fill: parent

        onClicked: NyshState.dashOpen = false

        BRectangle {
            id: home

            property var maxSize: 0

            bottomRightRadius: 10
            topRightRadius: 10
            border.color: "transparent"
            height: parent.height
            width: NyshState.dashOpen ? maxSize : 0
            clip: true
            MouseArea {
                anchors.fill: parent
            }

            Component.onCompleted: () => maxSize = homeWindow.screen.width * (2 / 7)

            Behavior on width {
                PropertyAnimation {
                    id: anim
                    duration: 200
                    Component.onCompleted: () => {
                        homeWindow.animRunning = Qt.binding(() => anim.running);
                    }
                }
            }

            RowLayout {
                anchors.fill: parent

                Item {
                    width: 30
                    Layout.fillHeight: true
                }

                StackView {
                    id: stack
                    initialItem: main
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    height: parent.height
                    Layout.margins: 15
                    clip: true

                    Component.onCompleted: NyshState.dashOpenChanged.connect(() => {
                        if (!NyshState.dashOpen) {
                            stack.clear();

                            stack.push(stack.initialItem);
                        }
                    })
                }

                Component {
                    id: main
                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        height: parent.height
                        Layout.margins: 15
                        Layout.alignment: Qt.AlignBottom

                        NotificationInbox {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        WeatherMedium {
                            Layout.fillWidth: true
                            height: 100
                        }

                        GridLayout {

                            rows: 2
                            columns: 2

                            Text {
                                text: "brightness"
                            }

                            Slider {
                                id: b
                                from: 0
                                to: 100
                                stepSize: 1
                                value: Brightness.value
                                onMoved: Brightness.value = value
                            }

                            BButton {
                                text: "Internet"
                                onClicked: stack.push(internet)
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                height: 30
                            }

                            BButton {
                                text: "Bluetooth"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                height: 30
                            }
                        }
                        MprisSmall {}
                    }
                }

                Component {
                    id: internet
                    BigWifiView {
                        onNavigationReturn: stack.pop()
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
