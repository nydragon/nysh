import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Quickshell

MouseArea {
    required property SystemTrayItem item
    Layout.fillWidth: true
    Layout.preferredHeight: parent.width

    onClicked: event => {
        switch (event.button) {
        case Qt.LeftButton:
            item.activate();
            break;
        default:
            console.log("Buttonevent unhandled");
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: parent.width
        Layout.alignment: Qt.AlignHCenter

        color: "black"
        radius: 3
        height: width
        width: parent.width

        Image {
            source: item.icon

            width: parent.width
            height: parent.height
            fillMode: Image.Stretch
        }
    }
}
