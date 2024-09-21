import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

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
            item.hasMenu && menu.open();
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

    IconImage {
        source: root.item.icon

        width: parent.width
        height: parent.height
    }
}
