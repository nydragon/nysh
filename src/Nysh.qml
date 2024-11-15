import QtQuick
import Quickshell
import Quickshell.I3
import "provider"

Item {
    id: root

    required property ShellScreen screen

    property MainBar mainBar: MainBar {
        screen: root.screen
    }

    Component.onCompleted: {
        I3.focusedMonitorChanged.connect(e => {
            dash.focused = I3.monitorFor(root.screen).focused;
        });
    }

    property Dashboard dash: Dashboard {
        screen: root.screen
        focused: I3.monitorFor(root.screen).focused
    }
}
