import QtQuick
import Quickshell.Io

Item {
    property int active: 1 // currently active workspace
    property int amount: 10 // amount of workspaces
    property string name: "" // name of the current desktop

    Process {
        property string name: ""

        command: ["env"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                if (data.startsWith("XDG_CURRENT_DESKTOP="))
                    name = data.slice(20);
            }
        }
    }

    Process {
        command: ["swaymsg", "-mtsubscribe", "[\"workspace\"]"]
        running: name === "sway"

        stdout: SplitParser {
            onRead: data => {
                const parsed = JSON.parse(data);
                if (parsed.change == "focus") {
                    active = parsed.current.num;
                }
            }
        }
    }
}
