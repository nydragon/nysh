pragma Singleton

import Quickshell.Io
import Quickshell

Singleton {
    id: inhibitor

    property bool active: false
    readonly property string caffeinatedLock: `${Quickshell.env("XDG_RUNTIME_DIR")}/qs-inhibitor`

    function toggle() {
        if (!active) {
            create.running = true;
        } else {
            removing.running = true;
        }
    }

    Process {
        running: true
        command: ["stat", inhibitor.caffeinatedLock]
        onExited: (code, status) => {
            inhibitor.active = !code;
        }
    }

    Process {
        id: create
        running: false
        command: ["touch", inhibitor.caffeinatedLock]
        onExited: (code, status) => {
            inhibitor.active = !code;
        }
    }

    Process {
        id: removing
        running: false
        command: ["rm", inhibitor.caffeinatedLock]
        onExited: (code, status) => {
            inhibitor.active = code != 0;
        }
    }

    Process {
        running: inhibitor.active
        command: ["systemd-inhibit", "--what", "idle", "sleep", "infinity"]
    }
}
