import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQml
import "base"
import "widgets/mpris"
import "provider"

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

            ListView {
                width: parent.width
                height: parent.height
                model: Notifications.incoming

                delegate: Rectangle {
                    required property var modelData
                    width: 100
                    height: 50
                    Text {
                        text: parent.modelData.appName
                        width: parent.width
                        height: parent.height
                    }
                }
            }

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

                    MprisSmall {}
                }
            }
        }
    }
}
