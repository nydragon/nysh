import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io // for Process
import "root:base"

BRectangle {
    id: workspaces
    property int workspaceN: 10
    property int activeN: 1
    height: 100 + col.spacing * (workspaceN - 1)

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
                        workspaces.activeN = parsed.current.num;
                    }
                }
            }
        }

        Repeater {
            model: workspaceN

            WorkspaceElem {
                required property int modelData
                wnum: modelData + 1
                focused: activeN === (modelData + 1)
            }
        }
    }
}
