import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../provider"

PanelWindow {
    id: root
    anchors {
        left: true
        top: true
        right: true
        bottom: true
    }
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    visible: NyshState.screenshot.open
    onVisibleChanged: view.captureFrame()

    ScreencopyView {
        id: view
        captureSource: root.screen
        anchors.fill: parent
    }

    ScreenshotUI {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10
    }
}
