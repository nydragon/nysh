import Quickshell.Io
import QtQuick
import Quickshell

Item {
    id: root

    required property ShellScreen screen
    property bool enabled: false

    property IpcHandler ipc: IpcHandler {
        target: "dash"

        function toggle() {
            root.enabled = !root.enabled;
        }
    }

    property MainBar mainBar: MainBar {
        screen: root.screen
        root: root
    }

    property Dashboard dash: Dashboard {
        screen: root.screen
        root: root
    }
}
