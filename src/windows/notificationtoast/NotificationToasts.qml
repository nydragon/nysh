import QtQuick
import Quickshell
import QtQuick.Controls
import "root:provider"
import "root:base"

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
            model: ListModel {
                id: data
                Component.onCompleted: () => {
                    Notifications._.notification.connect(e => {
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
