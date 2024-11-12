import "../../base"
import "../../provider"

import QtQuick
import Quickshell.Widgets
import Quickshell

BRectangle {
    id: caffeine

    MouseArea {
        anchors.fill: parent

        IconImage {
            anchors.fill: parent
            anchors.margins: 4
            source: Inhibitor.active ? "root:assets/eye-open.svg" : "root:assets/eye-closed.svg"
        }

        onClicked: () => Inhibitor.toggle()
    }
}
