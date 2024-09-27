import QtQuick
import QtQuick.Controls

Button {
    property int size: 40
    required property var source
    icon.source: source
    icon.height: size
    icon.width: size

    background: Rectangle {
        color: "transparent"
    }
}
