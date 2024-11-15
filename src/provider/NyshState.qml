pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: state
    property bool dashOpen: false

    property IpcHandler ipc: IpcHandler {
        target: "dash"

        function toggle() {
            state.toggleDash;
        }
    }

    function toggleDash() {
        state.dashOpen = !state.dashOpen;
    }
}
