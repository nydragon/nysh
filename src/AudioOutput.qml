import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire

// TODO: on click open detailed sink options:
// - select default sink
// - adjust sink & source volume
// - mute sinks & sources

MouseArea {
    property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [sink]
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: label
            text: `${Math.round(sink.audio.volume * 100)}%`

            Layout.alignment: Qt.AlignHCenter
        }
        Slider {
            id: slider

            // BUG: For some reason need to hardcode the width as it is overflowing otherwise
            Layout.maximumWidth: 25

            value: sink.audio.volume
            stepSize: 0.01
            wheelEnabled: true
            handle: Rectangle {}
            onMoved: sink.audio.volume = value
        }
    }
}
