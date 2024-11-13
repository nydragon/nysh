import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQml
import "base"

PanelWindow {
    id: homeWindow

    required property var root
    property bool animRunning: false

    color: "transparent"
    visible: animRunning || homeWindow.root.enabled
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

        onClicked: homeWindow.root.enabled = false

        BRectangle {
            id: home

            property var maxSize: 0

            bottomRightRadius: 10
            topRightRadius: 10
            border.color: "transparent"
            height: parent.height
            width: homeWindow.root.enabled ? maxSize : 0
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

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    height: parent.height
                    Layout.margins: 15
                    Layout.alignment: Qt.AlignBottom

                    BRectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200
                        radius: 15

                        RowLayout {
                            anchors.fill: parent
                            clip: true
                            Rectangle {
                                Layout.margins: 20
                                Layout.preferredWidth: parent.height - (Layout.margins * 2)
                                Layout.preferredHeight: parent.height - (Layout.margins * 2)
                                Layout.maximumWidth: {
                                    const mWidth = parent.width - (Layout.margins * 2);
                                    return mWidth > 0 ? mWidth : 0;
                                }
                                Layout.fillHeight: true
                            }
                        }
                    }
                }
            }
        }
    }
}
