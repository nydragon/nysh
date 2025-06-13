import QtQuick
import Quickshell.Services.Pipewire
import "../../base"

// TODO: on click open detailed sink options:
// - select default sink
// - adjust sink & source volume
// - mute sinks & sources

BButton {
    id: root

    implicitWidth: parent.width
    implicitHeight: width

    property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [root.sink]
    }

    BText {
        text: {
            if (root.sink?.audio.muted)
                "";
            else if (root.sink?.audio.volume >= 0.5)
                "";
            else if (root.sink?.audio.volume > 0)
                "";
            else
                "";
        }

        fontSizeMode: Text.Fit
        anchors.centerIn: parent
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 20
    }
}
