import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

MouseArea {
    id: root

    required property SystemTrayItem item

    Layout.fillWidth: true
    Layout.preferredHeight: parent.width - 4

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
        anchor.window: root.QsWindow.window
        anchor.rect.x: root.x + root.QsWindow.contentItem?.width
        anchor.rect.y: root.y
        anchor.rect.height: root.height * 3
    }

    IconImage {
        source: {
            let icon = root.item.icon;

            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
            }

            return icon;
        }
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
    }
}
