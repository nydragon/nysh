import QtQuick
import Quickshell.Io

Item {
    id: root

    property int active: 1 // currently active workspace
    property int amount: 10 // amount of workspaces
    property string name: "" // name of the current desktop

    Process {
        command: ["env"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                if (data.startsWith("XDG_CURRENT_DESKTOP="))
                    root.name = data.slice(20);
            }
        }
    }

    Process {
        command: ["swaymsg", "-mtsubscribe", "[\"workspace\"]"]
        running: root.name === "sway"

        stdout: SplitParser {
            onRead: data => {
                const parsed = JSON.parse(data);
                if (parsed.change == "focus") {
                    root.active = parsed.current.num;
                }
            }
        }
    }
}
