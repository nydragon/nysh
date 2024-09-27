import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root
    required property PwNode node
    property string name: root.node?.properties["media.name"] ?? root.node?.description ?? ""

    PwObjectTracker {
        objects: [root.node]
    }
}
