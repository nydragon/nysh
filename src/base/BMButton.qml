import QtQuick
import "../provider"

MouseArea {
    id: root

    required property string text
    readonly property var colors: Colors.data.colors.dark
    readonly property int animationDuration: 100
    readonly property int radius: root.toggleable && root.active ? Math.max(width, height) / 6 : Math.max(width, height)

    property bool toggleable: false
    property bool active: false

    onClicked: active = !active
    hoverEnabled: true

    BRectangle {
        color: root.toggleable && !root.active ? root.colors.surface_container : root.colors.primary
        radius: root.radius
        anchors.fill: parent

        Behavior on radius {
            NumberAnimation {
                duration: root.animationDuration
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: root.animationDuration
            }
        }
    }

    Text {
        text: root.text
        anchors.fill: parent
        anchors.centerIn: parent
        font.pixelSize: parent.height
        color: root.toggleable && !root.active ? root.colors.on_surface_variant : Colors.data.colors.dark.on_primary
        fontSizeMode: Text.Fit
        height: parent.height
        width: parent.width
        horizontalAlignment: Text.AlignHCenter

        Behavior on color {
            ColorAnimation {
                duration: root.animationDuration
            }
        }
    }

    BRectangle {
        color: root.toggleable && !root.active ? root.colors.on_surface_variant : root.colors.on_primary
        visible: root.containsMouse
        radius: root.radius
        anchors.fill: parent
        opacity: root.containsPress ? 0.18 : 0.08

        Behavior on color {
            ColorAnimation {
                duration: root.animationDuration
            }
        }
    }
}
