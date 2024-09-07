import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Quickshell

MouseArea {
    id: root
    required property SystemTrayItem item
    Layout.fillWidth: true
    Layout.preferredHeight: parent.width
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: event => {
        switch (event.button) {
        case Qt.LeftButton:
            item.activate();
            break;
        case Qt.RightButton:
            if (!item.hasMenu)
                return;
            menu.open();
            break;
        default:
            console.log("Buttonevent unhandled");
        }
    }

    QsMenuAnchor {
        id: menu
        menu: root.item.menu
        anchor.window: lbar
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
            source: root.item.icon

            width: parent.width
            height: parent.height
            fillMode: Image.Stretch
        }
    }
}
