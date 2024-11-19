import QtQuick
import "../provider"

MouseArea {
    id: mouse

    property string text: ""

    cursorShape: Qt.PointingHandCursor

    onClicked: {
        click.color = "red";
        b.start();
    }

    hoverEnabled: true

    BRectangle {
        id: click
        anchors.fill: parent
        color: Qt.darker(Config.colourMain, 1.1)

        ColorAnimation on color {
            id: b

            to: Qt.darker(Config.colourMain, 1.1)
            duration: 300
        }

        Rectangle {
            id: hover
            visible: mouse.containsMouse
            anchors.fill: parent
            radius: parent.radius
            color: "#9F9F9FC8"
        }

        Text {
            visible: mouse.text?.length > 0
            text: mouse.text
            anchors.centerIn: parent
        }
    }
}
