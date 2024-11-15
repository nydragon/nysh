import Quickshell
import Quickshell.I3
import QtQuick
import QtQuick.Layouts
import QtQml
import "base"
import "widgets/mpris"
import "widgets/notifications"
import "provider"

PanelWindow {
    id: homeWindow

    property bool animRunning: false
    property bool focused: I3.monitorFor(homeWindow.screen).focused

    color: "transparent"
    visible: (animRunning || NyshState.dashOpen) && focused
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

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    height: parent.height
                    Layout.margins: 15
                    Layout.alignment: Qt.AlignBottom

                    ListView {
                        id: popupcol
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1000
                        spacing: 10
                        width: parent.width
                        Component.onCompleted: () => {}

                        model: Notifications.list

                        delegate: NotificationToast {
                            id: toast

                            required property var modelData
                            required property int index

                            notif: modelData
                            width: ListView.view.width

                            onClose: {
                                toast.notif.dismiss();
                            }
                        }
                    }

                    MprisSmall {}
                }
            }
        }
    }
}
