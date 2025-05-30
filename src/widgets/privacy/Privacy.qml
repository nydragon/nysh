import "../../base"
import "../../provider"
import Quickshell.Services.Pipewire
import Quickshell
import QtQuick

BRectangle {
    id: root

    readonly property bool shareVideo: Pipewire.nodes.values.find(node => node.type === PwNodeType.VideoSource) ?? false
    readonly property bool shareAudio: Pipewire.nodes.values.find(node => node.type === PwNodeType.AudioInStream) ?? false

    color: Colors.data.colors.dark.error
    height: shareAudio || shareVideo ? Math.max(width, col.height + col.margins * 2) : 0
    visible: height
    radius: width

    Behavior on height {
        NumberAnimation {
            duration: 100
        }
    }

    Column {
        id: col
        property int margins: 0
        width: parent.width
        spacing: 1
        anchors.centerIn: parent

        Item {
            visible: root.shareAudio && root.shareVideo
            height: 3
            width: parent.width
        }

        BIcon {
            id: videoIcon
            height: root.shareVideo ? 30 : 0
            width: 30
            anchors.horizontalCenter: parent.horizontalCenter
            text: "󱒃"
            bodyColor: "transparent"
            textColor: Colors.data.colors.dark.on_error
            visible: height > 0

            Behavior on height {
                NumberAnimation {
                    duration: 100
                }
            }
        }

        BIcon {
            height: root.shareAudio ? 30 : 0
            width: 30
            anchors.horizontalCenter: parent.horizontalCenter
            text: ""
            bodyColor: "transparent"
            textColor: Colors.data.colors.dark.on_error
            visible: height > 1

            Behavior on height {
                NumberAnimation {
                    duration: 100
                }
            }
        }

        Item {
            visible: root.shareAudio && root.shareVideo
            height: 3
            width: parent.width
        }
    }
}
