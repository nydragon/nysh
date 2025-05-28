import "../../base"
import "../../provider"
import Quickshell.Services.Pipewire
import QtQuick.Layouts

BRectangle {
    id: root
    color: Colors.data.colors.dark.error
    height: col.height + col.anchors.margins * 2

    readonly property bool shareVideo: Pipewire.nodes.values.find(node => node.type === PwNodeType.VideoSource) ?? false
    readonly property bool shareAudio: Pipewire.nodes.values.find(node => node.type === PwNodeType.AudioInStream) ?? false

    visible: shareAudio || shareVideo

    ColumnLayout {
        id: col
        width: parent.width
        spacing: 1
        anchors.margins: 3
        anchors.centerIn: parent

        BIcon {
            Layout.preferredWidth: 30
            Layout.preferredHeight: 30
            text: "󱒃"
            bodyColor: "transparent"
            textColor: Colors.data.colors.dark.on_error
            visible: root.shareVideo
        }

        BIcon {
            Layout.preferredWidth: 30
            Layout.preferredHeight: 30
            text: ""
            bodyColor: "transparent"
            textColor: Colors.data.colors.dark.on_error
            visible: root.shareAudio
        }
    }
}
