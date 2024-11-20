pragma Singleton

import Quickshell.Io
import Quickshell

Singleton {
    id: inhibitor

    property bool active: false

    function toggle() {
        active = !active;
    }

    Process {
        running: inhibitor.active
        command: ["systemd-inhibit", "--what", "idle", "sleep", "infinity"]
    }
}
