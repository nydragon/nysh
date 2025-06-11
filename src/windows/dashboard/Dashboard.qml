import QtQuick
import QtQml
import Quickshell
import Quickshell.Hyprland
import "../../provider"

PanelWindow {
    id: root
    anchors {
        left: true
        top: true
        right: true
        bottom: true
    }

    visible: NyshState.dashOpen || dashboard.opacity != 0
    color: "transparent"

    property bool isOnActiveMonitor: true

    Component.onCompleted: {
        NyshState.dashOpenChanged.connect(() => {
            if (NyshState.dashOpen)
                isOnActiveMonitor = Hyprland.focusedMonitor.name === root.screen.name;
        });
    }

    MouseArea {
        anchors.fill: parent
        onClicked: NyshState.dashOpen = false

        containmentMask: QtObject {
            function contains(point: point): bool {
                const {
                    x,
                    y,
                    width,
                    height
                } = dashboard;

                return !root.isOnActiveMonitor || !(x < point.x && point.x < (x + width) && y < point.y && point.y < (y + height));
            }
        }
    }

    DashboardUI {
        id: dashboard
        shown: NyshState.dashOpen && root.isOnActiveMonitor
        width: 500
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: shown ? 10 : 20

        Behavior on anchors.margins {
            NumberAnimation {
                duration: 100
            }
        }
    }
}
