import "../../base"
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

BRectangle {
    property int margins: 2

    width: parent.width * 0.85
    height: childrenRect.height + margins * 2

    ColumnLayout {
        Layout.alignment: Qt.AlignCenter
        Layout.margins: parent.margins
        width: parent.width

        Repeater {
            model: SystemTray.items
            SysTrayItem {
                required property SystemTrayItem modelData
                item: modelData
            }
        }
    }
}
