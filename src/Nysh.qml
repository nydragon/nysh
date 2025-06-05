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

        PopupWindow {
            anchor.window: root.mainBar
            anchor.rect.x: root.mainBar.implicitWidth
            anchor.rect.y: 0
            implicitWidth: 500
            implicitHeight: screen.height
            visible: dashboard.opacity != 0
            color: "transparent"

            Dashboard {
                id: dashboard
                shown: NyshState.dashOpen
                anchors.fill: parent
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
