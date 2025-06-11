import QtQuick
import Quickshell
import Quickshell.Hyprland

MouseArea {
    id: root
    property bool active

    signal save(x: int, y: int, width: int, height: int)

    onClicked: root.save(x, y, width, height)

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: root.active ? 0 : 0.3
    }
}
