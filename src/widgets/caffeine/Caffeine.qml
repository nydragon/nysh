import "../../base"
import "../../provider"

import Quickshell.Widgets

BButton {
    id: caffeine

    IconImage {
        anchors.fill: parent
        anchors.margins: 4
        source: Inhibitor.active ? "root:assets/eye-open.svg" : "root:assets/eye-closed.svg"
    }

    onClicked: () => Inhibitor.toggle()
}
