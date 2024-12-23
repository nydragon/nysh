pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: state
    property bool dashOpen: false
    property bool workspaceViewOpen: false

    property bool binBrightnessctl: false

    property bool dndOn: false

    Process {
        command: ["which", "brightnessctl"]
        running: true
        onExited: (code, status) => {
            state.binBrightnessctl = !code;
        }
    }

    IpcHandler {
        target: "dash"

        function toggle() {
            state.toggleDash();
        }
    }

    IpcHandler {
        target: "dnd"

        function toggle() {
            state.toggleDnD();
        }

        function set(val: bool) {
            state.dndOn = val;
        }
    }

    IpcHandler {
        target: "workspace-view"

        function toggle() {
            state.toggleWorkspaceView();
        }
    }

    function toggleDnD() {
        state.dndOn = !state.dndOn;
    }

    function toggleWorkspaceView() {
        state.workspaceViewOpen = !state.workspaceViewOpen;
    }

    function toggleDash() {
        state.dashOpen = !state.dashOpen;
    }
}
