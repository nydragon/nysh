import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "../../provider"
import "../../base"

Scope {
    id: root

    property bool show: false

    function showOsd() {
        this.show = true;
        timeout.restart();
    }

    Timer {
        id: timeout
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            root.show = false;
        }
    }

    Connections {
        target: Audio.sink?.audio ?? null

        function onVolumeChanged() {
            if (!Audio.ready)
                return;
            root.showOsd();
        }
    }

    Loader {
        id: osdLoader
        active: root.show

        sourceComponent: PanelWindow {
            anchors {
                bottom: true
            }

            WlrLayershell.layer: WlrLayer.Overlay
            exclusionMode: ExclusionMode.Normal

            implicitWidth: 500
            implicitHeight: 300

            ColumnLayout {
                anchors {
                    top: parent.top
                    right: parent.right
                    left: parent.left
                    bottom: parent.bottom
                    bottomMargin: 100
                    margins: 20
                }

                BRectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "red"
                    radius: width / 2
                }
            }
        }
    }
}
