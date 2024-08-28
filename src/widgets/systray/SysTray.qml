import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import "root:base"

BRectangle {
    height: 112

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        padding: parent.border.width * 2

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ColumnLayout {
            anchors.fill: parent

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
