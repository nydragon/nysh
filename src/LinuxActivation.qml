// Credits go to outfoxxed: https://git.outfoxxed.me/outfoxxed/quickshell-examples/src/branch/master/activate_linux/shell.qml
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Variants {
    // Create the panel once on each monitor.
    model: Quickshell.screens

    PanelWindow {
        id: w

        property var modelData
        screen: modelData

        anchors {
            right: true
            bottom: true
        }

        margins {
            right: 50
            bottom: 50
        }

        width: content.width
        height: content.height

        color: "transparent"

        // Give the window an empty click mask so all clicks pass through it.
        mask: Region {}

        // Use the wlroots specific layer property to ensure it displays over
        // fullscreen windows.
        WlrLayershell.layer: WlrLayer.Overlay

        ColumnLayout {
            id: content

            Text {
                text: "Activate Linux"
                color: "#50ffffff"
                font.pointSize: 22
            }

            Text {
                text: "Go to Settings to activate Linux"
                color: "#50ffffff"
                font.pointSize: 14
            }
        }
    }
}
