import QtQuick
import "../provider"

MouseArea {
    id: mouse

    property string text: ""

    cursorShape: Qt.PointingHandCursor

    hoverEnabled: true

    BRectangle {
        id: self
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        Text {
            visible: mouse.text?.length > 0
            text: mouse.text
            anchors.centerIn: parent
        }

        states: [
            State {
                name: "moved"
                when: mouse.containsMouse && !mouse.pressed
                PropertyChanges {
                    target: self
                    width: mouse.width + 3
                    height: mouse.height + 3
                }
            },
            State {
                name: "clicked"
                when: mouse.pressed
                PropertyChanges {
                    target: self
                    width: mouse.width - 3
                    height: mouse.height - 3
                }
            }
        ]

        transitions: Transition {
            NumberAnimation {
                properties: "width,height"
                easing.type: Easing.OutBack
                easing.overshoot: 5
                duration: 200
            }
        }
    }
}
