import QtQuick
import "../provider"

MouseArea {
    id: root
    hoverEnabled: true
    required property string text
    property bool toggleable: false
    property bool active: false
    readonly property var colors: Colors.data.colors.dark
    readonly property int animationDuration: 100

    onClicked: active = !active

    BRectangle {
        color: root.toggleable && !root.active ? root.colors.surface_container : root.colors.primary

        radius: root.toggleable && root.active ? Math.max(width, height) / 6 : Math.max(width, height)
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
        radius: width
        anchors.fill: parent
        opacity: root.containsPress ? 0.18 : 0.08

        Behavior on color {
            ColorAnimation {
                duration: root.animationDuration
            }
        }
    }
}
