import QtQuick
import QtQuick.Layouts
import "provider"

Rectangle {
    width: parent.width
    height: clock.height * 1.5
    anchors.bottomMargin: 5
    anchors.topMargin: 5
    border.color: "black"
    border.width: 2
    radius: 5

    Rectangle {
        id: clock
        height: hours.height + minutes.height
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: hours
            anchors.horizontalCenter: parent.horizontalCenter
            font.weight: Font.ExtraBold
            text: String(Time.date.getHours()).padStart(2, '0')
        }
        Text {
            id: minutes
            anchors.top: hours.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.weight: Font.ExtraBold
            text: String(Time.date.getMinutes()).padStart(2, '0')
        }
    }
}
