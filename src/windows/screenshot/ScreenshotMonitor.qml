import QtQuick

MouseArea {
    id: root
    property bool active
    required property color unfocusedColor

    Rectangle {
        anchors.fill: parent
        color: root.unfocusedColor
        opacity: root.active ? 0 : 1
    }
}
