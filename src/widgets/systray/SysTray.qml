import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import "root:base"

BRectangle {
    height: 100

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        padding: parent.border.width

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 4

            Repeater {
                model: SystemTray.items

                SysTrayItem {
                    required property SystemTrayItem modelData
                    item: modelData
                }
            }
        }
    }
}
