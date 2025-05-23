import QtQuick
import QtQuick.Controls

BRectangle {
    property int size: 40
    required property var source
    icon.source: source
    icon.height: size
    icon.width: size
    radius: width

    background: Rectangle {
        color: "transparent"
    }
}
