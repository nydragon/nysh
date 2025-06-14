pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import "../../provider"

Canvas {
    id: root

    property var workspaceId: this.monitor.activeWorkspace?.id
    property var selection: null
    required property HyprlandMonitor monitor
    property bool active: this.monitor.focused
    required property color unfocusedColor

    signal save(x: int, y: int, width: int, height: int)

    onActiveChanged: this.requestPaint()

    anchors.fill: parent

    Component.onCompleted: NyshState.screenshot.modeChanged.connect(() => this.requestPaint())

    onPaint: {
        const ctx = getContext("2d");
        ctx.fillStyle = this.unfocusedColor;
        ctx.globalCompositeOperation = "copy";

        ctx.clearRect(0, 0, width, height);
        ctx.beginPath();
        ctx.fillRect(0, 0, width, height);

        if (selection && this.active) {
            ctx.clearRect(...selection);
        }
    }

    Repeater {
        id: rep

        model: Hyprctl.clients?.filter(w => w.workspace.id === root.workspaceId) ?? []

        onVisibleChanged: {
            if (this.visible)
                Hyprctl.get(Hyprctl.Type.Clients);
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
