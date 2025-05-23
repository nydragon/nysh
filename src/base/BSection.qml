import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import "../provider"

ColumnLayout {
    property bool open: false
    property alias color: button.color
    onOpenChanged: {
        if (open) {
            chevron.rotation = 90;
        } else {
            chevron.rotation = 0;
        }
    }

    BButton {
        id: button
        Layout.fillWidth: true
        Layout.preferredHeight: 20
        text: "Audio"

        IconImage {
            id: chevron
            source: "root:assets/chevron-right.svg"
            height: parent.height
            width: parent.height
            anchors.left: parent.left
            rotation: 0

            Behavior on rotation {
                NumberAnimation {
                    duration: 100
                }
            }
        }

        onContainsMouseChanged: () => {
            if (containsMouse) {
                color = "#14" + Colors.data.colors.dark.on_secondary_container.replace("#", "");
            } else if (parent.open) {
                color = "#19" + Colors.data.colors.dark.on_secondary_container.replace("#", "");
            } else {
                color = "transparent";
            }
        }

        onClicked: parent.open = !parent.open
    }
}
