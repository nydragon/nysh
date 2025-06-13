import QtQuick
import "../provider"

Rectangle {
    width: parent.width
    height: width
    radius: 5
    color: "transparent"

    Behavior on color {
        ColorAnimation {
            duration: Config.data.colourFadeSpeed
        }
    }
}
