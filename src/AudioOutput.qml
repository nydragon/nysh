import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire

// TODO: on click open detailed sink options:
// - select default sink
// - adjust sink & source volume
// - mute sinks & sources

// BUG: When controlling audio from outside of QS, the change is reflected, but if audio in pavucontrol is not 100%
// QS can only change from 0 to whatever is set in pavucontrol
Rectangle {
    id: test
    width: parent.width
    height: (icon.height + slider.height) * 1.5
    anchors.bottomMargin: 5
    anchors.topMargin: 5
    border.color: "black"
    border.width: 2
    radius: 5

    property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [sink]
    }

    MouseArea {
        id: audio_area

        anchors.fill: parent

        onClicked: {}
        onWheel: wheel => {
            const newVal = sink.audio.volume + (wheel.angleDelta.y / 12000);
            sink.audio.volume = newVal < 1.0 ? (newVal > 0 ? newVal : 0.0) : 1.0;
        }

        Rectangle {
            width: parent.width
            color: "#00000000"

            height: icon.height + slider.height
            anchors.verticalCenter: parent.verticalCenter

            // TODO: Make icon depend on sink type and volume level
            Image {
                id: icon
                source: "speaker.png"
                width: parent.width * (2 / 3)

                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
            Slider {
                id: slider
                anchors.top: icon.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                height: background.height
                width: parent.width * 0.75
                enabled: false
                value: sink.audio.volume
                stepSize: 0.01
                wheelEnabled: true

                contentItem: Rectangle {
                    color: "#3191CD" // Change color based on value
                    radius: 5
                    width: slider.width * (slider.value / slider.to)
                    height: parent.height
                }

                background: Rectangle {
                    color: "#C4C4C4"
                    radius: 5
                    height: 4
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                }

                handle: Rectangle {}
                onMoved: sink.audio.volume = value
            }
        }
    }
}
