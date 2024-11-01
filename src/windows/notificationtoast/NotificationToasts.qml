import QtQuick
import Quickshell
import QtQuick.Controls
import "root:provider"
import "root:base"

PopupWindow {
    id: popups
    required property var win
    anchor {
        rect.x: lbar.width * 1.2
        window: popups.win
    }

    visible: true

    mask: Region {
        item: popups

        Region {
            intersection: Intersection.Combine
            height: popupcol.count * 26 + popupcol.count * popupcol.spacing + (mouseArea.containsMouse * 114)
            width: 300
        }
    }

    color: "transparent"
    height: popupcol.count * 26 + 300
    width: 300

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent

        ListView {
            id: popupcol
            anchors.margins: lbar.width * 0.2
            anchors.fill: parent
            model: ListModel {
                id: data
                Component.onCompleted: () => {
                    console.log(popupcol.count);
                    Notifications.d.notification.connect(e => {
                        data.insert(0, e);
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

            spacing: 10
            delegate: Toast {}
        }
    }
}
