pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: state

    property alias dashOpen: persist.dashOpen
    property bool workspaceViewOpen: false

    property bool binBrightnessctl: false

    property bool dndOn: false

    property PersistentProperties persist: PersistentProperties {
        id: persist
        reloadableId: "persistedStates"

        property bool dashOpen: false
    }

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
        persist.dashOpen = !persist.dashOpen;
    }
}
