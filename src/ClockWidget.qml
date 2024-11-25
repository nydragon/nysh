import QtQuick
import "provider"
import "base"

BRectangle {
    height: clock.height * 1.5

    Item {
        id: clock
        height: hours.height + minutes.height
        width: parent.width
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
