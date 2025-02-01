import "../../base"
import "../../provider"

import QtQuick
import Quickshell.Widgets

BButton {
    id: caffeine

    onClicked: () => Inhibitor.toggle()

    IconImage {
        anchors.fill: parent
        anchors.margins: 4
        source: Inhibitor.active ? "root:assets/eye-open.svg" : "root:assets/eye-closed.svg"
    }
}
