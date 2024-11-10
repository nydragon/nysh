import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.I3
import QtQuick.Layouts

PanelWindow {
    id: workspaceView

    IpcHandler {
        target: "workspace-view"

        function toggle() {
            workspaceView.visible = !workspaceView.visible;
        }
    }

    focusable: true

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

        Component.onCompleted: () => {
            const qs = "/nix/store/78nmm1gzgwfvqgj4pmzi4dgjjzyh8amn-quickshell-0.1.0/bin/quickshell";
            const conf = "~/devel/projects/nysh/src/shell.qml";
            I3.dispatch(`bindsym Mod4+M exec "${qs} -p ${conf} msg workspace-view toggle"`);
        }
    }

    color: "transparent"

    width: content?.width ?? 500
    height: content?.height ?? 500
    visible: true

    Component.onCompleted: () => {
        I3.focusedWorkspaceChanged.connect(() => workspaceView.visible = false);
    }
}
