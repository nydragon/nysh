pragma Singleton

import Quickshell.Io
import Quickshell

Singleton {
    id: inhibitor
    property var toggle: () => {
        active = !active;
    }
    property bool active: false

    Process {
        running: inhibitor.active
        command: ["systemd-inhibit", "--what", "idle", "sleep", "infinity"]
    }
}
