pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import "provider"

Item {
    id: root

    required property ShellScreen screen

    property MainBar mainBar: MainBar {
        screen: root.screen
    }

    LazyLoader {
        loading: true

        PanelWindow {
            anchors {
                left: true
                top: true
                right: true
                bottom: true
            }

            visible: dashboard.opacity != 0
            color: "transparent"

            MouseArea {
                id: r
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

                        return !(x < point.x && point.x < (x + width) && y < point.y && point.y < (y + height));
                    }
                }
            }

            Dashboard {
                id: dashboard
                shown: NyshState.dashOpen
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
    }
}
