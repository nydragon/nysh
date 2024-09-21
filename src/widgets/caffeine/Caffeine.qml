import "root:base"
import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import Quickshell

BRectangle {
    id: caffeine
    property bool inhibiting: false

    MouseArea {
        anchors.fill: parent

        IconImage {
            anchors.fill: parent
            anchors.margins: 4
            source: caffeine.inhibiting ? "root:assets/eye-open.svg" : "root:assets/eye-closed.svg"
        }

        onClicked: () => {
            caffeine.inhibiting = !caffeine.inhibiting;
        }

        Process {
            id: inhibitor
            running: caffeine.inhibiting
            command: ["systemd-inhibit", "sleep", "infinity"]
        }
    }
}
