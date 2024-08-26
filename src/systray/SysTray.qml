import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray

Rectangle {
    id: aoutput
    width: parent.width
    height: 100
    anchors.bottomMargin: 5
    anchors.topMargin: 5
    border.color: "black"
    border.width: 2
    radius: 5

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
                // Show all sources, regardless of what sink they are assigned to
                model: SystemTray.items

                SysTrayItem {
                    required property SystemTrayItem modelData
                    item: modelData
                }
            }
        }
    }
}
