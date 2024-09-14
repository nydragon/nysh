pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    id: root

    property int activeWorkspace: 1
    property var dispatch: m => {
        sender.command = ["swaymsg", ...m];
        sender.running = true;
    }

    Process {
        id: sender
        command: []
    }

    Process {
        command: ["swaymsg", "-mtsubscribe", "[\"workspace\"]"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const parsed = JSON.parse(data);
                if (parsed.change == "focus") {
                    root.activeWorkspace = parsed.current.num;
                }
            }
        }
    }
}
