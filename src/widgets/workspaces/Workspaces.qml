import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io // for Process

Rectangle {
    id: workspaces
    property int workspaceN: 10
    width: parent.width
    height: 100 + col.spacing * (workspaceN - 1)
    anchors.bottomMargin: 5
    anchors.topMargin: 5
    border.color: "black"

    border.width: 2
    radius: 5

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        Layout.alignment: Qt.AlignHCenter
        spacing: 1

        Process {
            id: getwork
            command: ["swaymsg", "-mtsubscribe", "[\"workspace\"]"]
            running: true

            stdout: SplitParser {
                splitMarker: "\n"
                onRead: data => {
                    const parsed = JSON.parse(data);
                    if (parsed.change == "focus") {
                        col.work = parsed.current.num;
                    }
                }
            }
        }

        property int work: 1

        Repeater {
            model: workspaceN

            WorkspaceElem {
                required property int modelData
                workspaceNum: modelData + 1
                activeWorkspaceNum: col.work
            }
        }
    }
}
