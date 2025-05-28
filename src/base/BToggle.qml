import QtQuick
import "../provider"

MouseArea {
    id: root
    hoverEnabled: true
    property string text: ""
    property bool active: false
    readonly property var colors: Colors.data.colors.dark
    readonly property int transitionSpeed: 100
    state: active ? "active" : "inactive"
    width: 52
    height: 32
    onClicked: active = !active

    BRectangle {
        id: track
        radius: Math.max(width, height)
        anchors.fill: parent
        border.color: root.colors.outline
        border.width: 2

        BRectangle {
            id: handle

            readonly property int margin: (parent.height - height) / 2
            property int diameter: 16
            radius: diameter
            height: diameter
            width: diameter
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: margin
        }
    }

    states: [
        State {
            name: "active"
            PropertyChanges {
                track.color: root.colors.primary
                handle {
                    color: root.colors.on_primary
                    x: handle.width - handle.margin
                    diameter: 24
                }
            }
        },
        State {
            name: "inactive"
            PropertyChanges {
                track.color: root.colors.surface_container
                handle {
                    color: root.colors.outline
                    x: handle.margin
                    diameter: 16
                }
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "inactive"
            reversible: true
            ColorAnimation {
                target: track
                duration: root.transitionSpeed
            }
            ColorAnimation {
                target: handle
                duration: root.transitionSpeed
            }
            NumberAnimation {
                target: handle
                properties: "x,diameter"
                duration: root.transitionSpeed
            }
        },
        Transition {
            from: "*"
            to: "active"
            reversible: true
            ColorAnimation {
                target: track
                duration: root.transitionSpeed
            }
            ColorAnimation {
                target: handle
                duration: root.transitionSpeed
            }
            NumberAnimation {
                target: handle
                properties: "x,diameter"
                duration: root.transitionSpeed
            }
        }
    ]
}
