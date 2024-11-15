import QtQuick
import Quickshell
import QtQuick.Controls
import "root:provider"
import "root:base"
import "../../widgets/notifications"

PanelWindow {
    id: popups
    required property var win
    visible: true

    anchors {
        left: true
        top: true
        bottom: true
    }

    exclusionMode: ExclusionMode.Normal

    mask: Region {
        intersection: Intersection.Combine
        height: popupcol.contentHeight
        width: popups.width
    }

    color: "transparent"
    width: 500

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent

        ListView {
            id: popupcol
            anchors.margins: lbar.width * 0.2
            anchors.fill: parent
            focus: true
            spacing: 10

            model: ListModel {
                id: data
                Component.onCompleted: () => {
                    Notifications.incomingAdded.connect(n => {
                        data.insert(0, {
                            notif: n
                        });
                    });
                }
            }
            addDisplaced: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 100
                }
            }
            add: Transition {
                NumberAnimation {
                    properties: "y"
                    from: -50
                    duration: 1000
                }
            }
            remove: Transition {
                PropertyAction {
                    property: "ListView.delayRemove"
                    value: true
                }
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"
                        to: 0
                        duration: 300
                    }
                    NumberAnimation {
                        properties: "y"
                        to: -100
                        duration: 300
                    }
                }
                PropertyAction {
                    property: "ListView.delayRemove"
                    value: true
                }
            }

            delegate: NotificationToast {
                id: toast

                property int countdownTime: Config.notifications.toastDuration
                required property int index

                width: ListView.view.width
                showTimeBar: true

                Timer {
                    id: timer
                    interval: 100
                    onTriggered: () => {
                        toast.countdownTime -= interval;
                        if (toast.countdownTime <= 0) {
                            toast.close();
                        }
                    }
                    repeat: true
                    running: !toast.containsMouse && toast.countdownTime > 0
                }

                Component.onCompleted: notif.closed.connect(() => {
                    if (!toast || toast.index < 0)
                        return;
                    ListView.view.model.remove(toast.index, 1);
                })

                onClose: {
                    if (!toast || toast.index < 0)
                        return;
                    ListView.view.model.remove(toast.index, 1);
                }
            }
        }
    }
}
