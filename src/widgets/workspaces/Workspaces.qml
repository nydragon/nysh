pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../../base"

BRectangle {
    id: root
    height: 100 + layout.spacing * (workspace.amount - 1)

    WorkspaceIPC {
        id: workspace
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        Layout.alignment: Qt.AlignHCenter
        spacing: 1

        Repeater {
            model: workspace.amount

            WorkspaceElem {
                required property int modelData
                wnum: modelData + 1
                focused: workspace.active === (modelData + 1)
            }
        }
    }
}
