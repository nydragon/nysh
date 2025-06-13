import QtQuick

MouseArea {
    id: root
    property bool active

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: root.active ? 0 : 0.3
    }
}
