import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Sway

Item {
    id: root

    property int active: 1 // currently active workspace
    property int amount: 10 // amount of workspaces
    property string name: "unknown" // name of the current desktop

    property var switchWorkspace: w => {
        console.log(`We are switching from workspace ${active} to ${w}`);
        switch (root.name) {
        case "sway":
            Sway.dispatch(`workspace ${w}`);
            break;
        case "Hyprland":
            Hyprland.dispatch(`workspace ${w}`);
            break;
        default:
            console.log("unhandled");
        }
    }

    Process {
        command: ["env"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                if (data.startsWith("XDG_CURRENT_DESKTOP=")) {
                    root.name = data.slice(20);
                    switch (root.name) {
                    case "sway":
                        root.active = Qt.binding(() => Sway.focusedWorkspace?.num ?? root.active);
                        break;
                    case "Hyprland":
                        root.active = Qt.binding(() => Hyprland.focusedMonitor?.activeWorkspace?.id ?? root.active);
                        break;
                    default:
                        console.log("This desktop is unhandled:", root.name);
                    }
                }
            }
        }
    }
}
