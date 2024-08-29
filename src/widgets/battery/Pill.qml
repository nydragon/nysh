import QtQuick

Item {
    property real percentage: 0.3 // Percentage of fullness
    property real color: 0.7
    property int radius: 5

    Rectangle {
        id: background
        anchors.fill: parent
        radius: parent.radius
        color: `${Qt.hsla(parent.color, 0.2, 0.6, 1)}`
    }

    Rectangle {
        id: foreground
        radius: parent.radius
        height: parent.height * parent.percentage
        width: parent.width
        anchors.bottom: parent.bottom
        color: `${Qt.hsla(parent.color, 0.8, 0.6, 1)}`
    }
}
