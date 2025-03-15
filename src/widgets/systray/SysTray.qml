import "../../base"
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

BRectangle {
    width: parent.width
    height: childrenRect.height + margins * 2
    property int margins: 2;

    ColumnLayout {
        anchors.centerIn: parent
        anchors.margins: parent.margins
        width: parent.width - anchors.margins * 2
        Repeater {
            model: SystemTray.items
            SysTrayItem {
                required property SystemTrayItem modelData
                item: modelData
            }
        }
    }
}
