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
    mask: Region {
        item: popupcol
        intersection: Intersection.Xor
    }
    visible: true
    color: "transparent"
    height: 500
    width: 400
    ListView {
        id: popupcol
        anchors.margins: lbar.width * 0.2
        anchors.fill: parent
        model: ListModel {
            id: data
            Component.onCompleted: () => {
                Notifications.d.notification.connect(e => {
                    data.insert(0, e);
                    //data.append(e);
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
        }

        spacing: 10
        delegate: Toast {}
    }
}
