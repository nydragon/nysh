import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.I3

Item {
    id: root

    property int active: 1 // currently active workspace
    property int amount: 10 // amount of workspaces
    property string name: "unknown" // name of the current desktop

    property var switchWorkspace: w => {
        console.log(`We are switching from workspace ${active} to ${w}`);
        switch (root.name) {
        case "sway":
            I3.dispatch(`workspace ${w}`);
            break;
        case "Hyprland":
            Hyprland.dispatch(`workspace ${w}`);
            break;
        default:
            console.log("unhandled");
        }
    }

    Component.onCompleted: {
        root.name = Quickshell.env("XDG_CURRENT_DESKTOP");

        switch (root.name) {
        case "sway":
        case "none+i3":
            root.active = Qt.binding(() => I3.focusedWorkspace?.num ?? root.active);
            break;
        case "Hyprland":
            root.active = Qt.binding(() => Hyprland.focusedMonitor?.activeWorkspace?.id ?? root.active);
            break;
        default:
            console.log("This desktop is unhandled:", root.name);
        }
    }
}
