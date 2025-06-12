import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../provider"
import "../../provider/state"

PanelWindow {
    id: root

    property bool isOnActiveMonitor: true
    property bool showUI: true
    property HyprlandMonitor hyprlandMonitor: Hyprland.monitorFor(screen)

    function getFilename(): string {
        const timestamp = Qt.formatDateTime(new Date(), "yyyy-MM-dd-hh-mm-ss-zzz");
        return `${Quickshell.env("HOME")}/Pictures/${timestamp}.png`;
    }

    function save(x: int, y: int, width: int, height: int) {
        const geometry = `${x},${y} ${width}x${height}`;
        const filename = getFilename();

        root.showUI = false;
        saver.command = ["grim", "-g", geometry, filename];
        saver.running = true;

        print("Saved screenshot to", filename);
    }

    anchors {
        left: true
        top: true
        right: true
        bottom: true
    }
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    visible: NyshState.screenshot.open
    onVisibleChanged: view.captureFrame()
    Component.onCompleted: {
        NyshState.screenshot.openChanged.connect(() => {
            if (NyshState.screenshot.open)
                isOnActiveMonitor = Hyprland.focusedMonitor.name === root.screen.name;
        });
    }

    ScreencopyView {
        id: view
        captureSource: root.screen
        anchors.fill: parent
    }

    Process {
        id: saver
        command: []
        stdout: SplitParser {
            onRead: data => console.log(data)
        }
        stderr: SplitParser {
            onRead: data => console.log(data)
        }
        onStarted: root.showUI = false
        onExited: {
            root.showUI = true;
            NyshState.screenshot.setOpen(false);
        }
    }

    ScreenshotWindow {
        visible: root.showUI && NyshState.screenshot.mode === Screenshot.Mode.Window
        anchors.fill: parent
        workspaceId: Hyprland.monitorFor(root.screen)?.activeWorkspace?.id
        onSave: (a, b, c, d) => root.save(a, b, c, d)
    }

    ScreenshotMonitor {
        visible: root.showUI && NyshState.screenshot.mode === Screenshot.Mode.Monitor
        anchors.fill: parent
        active: Hyprland.monitorFor(root.screen).focused
        onClicked: () => root.save(root.hyprlandMonitor.x, root.hyprlandMonitor.y, root.hyprlandMonitor.width, root.hyprlandMonitor.height)
    }

    ScreenshotRegion {
        visible: root.showUI && NyshState.screenshot.mode === Screenshot.Mode.Region && Hyprland.focusedMonitor.name === root.screen?.name
        onSave: (a, b, c, d) => root.save(a, b, c, d)
    }

    ScreenshotUI {
        id: ui
        visible: root.showUI && root.isOnActiveMonitor
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10
    }
}
