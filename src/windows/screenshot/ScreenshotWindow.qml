pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import "../../provider"

Canvas {
    id: root

    property var workspaceId: monitor.activeWorkspace?.id
    property var selection: null
    required property HyprlandMonitor monitor

    signal save(x: int, y: int, width: int, height: int)

    anchors.fill: parent
    onVisibleChanged: Hyprctl.get(Hyprctl.Type.Clients)

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

    Repeater {
        id: rep

        Component.onCompleted: {
            Hyprctl.reply.connect((type, data) => {
                console.log(type, data);
                if (type === Hyprctl.Type.Clients) {
                    model = data.filter(w => w.workspace.id === root.workspaceId);
                }
            });
        }

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
