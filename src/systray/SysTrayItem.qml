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

        Component.onCompleted: () => {
            console.log(JSON.stringify(Object.entries(item), null, 2));
            console.log(height, width);
        }

        //height: icon.height
        //width: icon.width

        height: width

        width: parent.width

        // Text {
        //text: item.id
        //}
        //

        Image {
            id: icon
            source: item.icon

            //fillMode: Image.PreserveAspectFit

            //Layout.fillWidth: true

            width: parent.width
            height: parent.height
            //Layout.maximumWidth: parent.width
            //Layout.maximumHeight: parent.height

            //sourceSize.width: parent.width
            //sourceSize.height: parent.height
            //
            //horizontalAlignment: Image.AlignHCenter
            //verticalAlignment: Image.AlignVCenter
            fillMode: Image.Stretch
        }
    }
}
