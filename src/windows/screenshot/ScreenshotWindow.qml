pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

Canvas {
    id: root

    property var workspaceId: monitor.activeWorkspace?.id
    property var selection: null
    required property HyprlandMonitor monitor

    signal save(x: int, y: int, width: int, height: int)

    anchors.fill: parent
    onVisibleChanged: (getter.running = true)

    onPaint: {
        const ctx = getContext("2d");
        ctx.fillStyle = Qt.rgba(0, 0, 0, 0.2);
        ctx.globalCompositeOperation = "copy";

        ctx.clearRect(0, 0, width, height);
        ctx.beginPath();
        ctx.fillRect(0, 0, width, height);
        ctx.fill();

        if (selection) {
            ctx.clearRect(...selection);
        }
    }

    Process {
        id: getter

        property string rawData: ""
        property var data: []

        command: ["hyprctl", "clients", "-j"]
        onStarted: rawData = ""
        stdout: SplitParser {
            onRead: data => getter.rawData += data
        }
        onExited: {
            data = JSON.parse(rawData);
        }
    }

    Repeater {
        id: rep

        model: getter.data.filter(w => w.workspace.id === root.workspaceId)

        delegate: MouseArea {
            id: delegate
            required property var modelData
            x: modelData.at[0] - root.monitor.x
            y: modelData.at[1] - root.monitor.y
            width: modelData.size[0]
            height: modelData.size[1]
            hoverEnabled: true
            onEntered: {
                root.selection = [x, y, width, height];
                root.requestPaint();
            }
            onClicked: root.save(root.monitor.x + x, root.monitor.y + y, width, height)
        }
    }
}
