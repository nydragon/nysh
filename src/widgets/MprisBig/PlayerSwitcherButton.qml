import QtQuick
import QtQuick.Controls

Button {
    hoverEnabled: true
    background: Rectangle {
        color: "transparent"
        border.color: parent.hovered ? "red" : "blue"
        border.width: 2
        radius: 20
    }
}
