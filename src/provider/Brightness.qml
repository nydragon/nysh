pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: brightness
    property int value: -1
    property bool first: true
    function refresh() {
        get.running = true;
    }

    onValueChanged: () => {
        if (value >= 0) {
            set.value = brightness.value;
            set.running = true;
        }
    }

    Process {
        id: get
        command: ["brightnessctl", "i", "-m"]
        running: true
        stdout: SplitParser {
            onRead: rawData => {
                const value = Number(rawData.split(",")[3]?.replace("%", "") ?? "");
                if (!Number.isNaN(value)) {
                    brightness.value = value;
                }
            }
        }
    }

    Process {
        id: set

        property int value

        command: ["brightnessctl", "s", `${set.value}%`]
    }
}
