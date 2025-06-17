import QtQuick
import "../provider"

MouseArea {
    id: mouse

    property string text: ""
    property alias color: rect.color

    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onContainsMouseChanged: {
        if (containsMouse) {
            highlight.color = "#14" + Colors.data.colors.dark.on_secondary_container.replace("#", "");
        } else {
            highlight.color = "transparent";
        }
    }

    BRectangle {
        id: rect
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        BRectangle {
            id: highlight
            anchors.fill: parent

            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }
        }

        BText {
            visible: mouse.text?.length > 0
            text: mouse.text
            anchors.centerIn: parent
        }

        states: [
            State {
                name: "moved"
                when: mouse.containsMouse && !mouse.pressed
                PropertyChanges {
                    rect {
                        width: mouse.width + 3
                        height: mouse.height + 3
                    }
                }
            },
            State {
                name: "clicked"
                when: mouse.pressed
                PropertyChanges {
                    rect {
                        width: mouse.width - 3
                        height: mouse.height - 3
                    }
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
