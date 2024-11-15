import Quickshell
import QtQuick
import Quickshell.I3
import QtQuick.Layouts
import "../../provider"

PanelWindow {
    id: workspaceView

    visible: NyshState.workspaceViewOpen

    focusable: true
    color: "transparent"
    width: content?.width ?? 500
    height: content?.height ?? 500

    GridLayout {
        id: content

        anchors.centerIn: parent
        width: 1000
        height: 400
        anchors.margins: 4
        columns: 5

        Repeater {
            id: rep
            model: 10
            delegate: MouseArea {
                id: rec
                Layout.fillWidth: true
                Layout.fillHeight: true
                required property var modelData
                hoverEnabled: true

                onEntered: () => c.border.width = 30
                onExited: () => {
                    c.border.width = 1;
                }

                Rectangle {
                    id: c
                    anchors.fill: parent
                    Text {
                        id: name
                        text: rec.modelData + 1
                        anchors.centerIn: parent
                        font.pointSize: 30
                        color: I3.workspaces.values.find(e => e.name == rec.modelData + 1) ? "red" : Qt.rgba(0.96, 0.15, 0.56, 0.55)
                    }
                    border.color: Qt.rgba(0.96, 0.15, 0.56, 0.55)
                    border.width: 1
                    radius: 5
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                onClicked: () => I3.dispatch(`workspace ${rec.modelData + 1}`)
            }
        }
    }
}
