pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: state

    property alias dashOpen: persist.dashOpen
    property bool audioOpen: false
    property bool workspaceViewOpen: false
    property bool binBrightnessctl: false
    property bool dndOn: false
    property string home: Quickshell.env("HOME")

    property PersistentProperties persist: PersistentProperties {
        id: persist
        reloadableId: "persistedStatesNysh"

        property bool dashOpen: false
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

    function toggleAudio() {
        if (!persist.dashOpen) {
            persist.dashOpen = true;
            audioOpen = true;
        } else {
            audioOpen = !audioOpen;
        }
    }
}
