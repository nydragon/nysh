import QtQuick
import "../provider"

BRectangle {
    id: root

    required property string text
    readonly property var colors: Colors.data.colors.dark
    readonly property int animationDuration: Config.data.colourFadeSpeed
    property string textColor: Colors.data.colors.dark.on_primary
    property string bodyColor: Colors.data.colors.dark.primary

    color: bodyColor
    radius: Math.max(width, height) / 6

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

    Text {
        text: root.text
        anchors.fill: parent
        anchors.centerIn: parent
        font.pixelSize: parent.height
        fontSizeMode: Text.Fit
        height: parent.height
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        color: root.textColor

        Behavior on color {
            ColorAnimation {
                duration: root.animationDuration
            }
        }
    }
}
