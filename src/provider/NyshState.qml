pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: state
    property bool dashOpen: false
    property bool workspaceViewOpen: false

    IpcHandler {
        target: "dash"

        function toggle() {
            state.toggleDash();
        }
    }

    IpcHandler {
        target: "workspace-view"

        function toggle() {
            state.toggleWorkspaceView();
        }
    }

    function toggleWorkspaceView() {
        state.workspaceViewOpen = !state.workspaceViewOpen;
    }

    function toggleDash() {
        state.dashOpen = !state.dashOpen;
    }
}
