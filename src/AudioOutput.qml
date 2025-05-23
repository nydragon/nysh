import QtQuick
import Quickshell.Services.Pipewire
import "windows/audioman"
import "base"

// TODO: on click open detailed sink options:
// - select default sink
// - adjust sink & source volume
// - mute sinks & sources

BButton {
    id: audiow

    implicitWidth: parent.width
    implicitHeight: width

    property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [audiow.sink]
    }

    property AudioManager audioman: AudioManager {}

    onClicked: {
        audioman.visible = !audioman.visible;
    }

    BText {
        text: {
            if (audiow.sink?.audio.muted)
                "";
            else if (audiow.sink?.audio.volume >= 0.5)
                "";
            else if (audiow.sink?.audio.volume > 0)
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
