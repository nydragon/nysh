pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "../../base"

Column {
    id: root

    property int defaultSinkId: Pipewire.defaultAudioSink?.id ?? -1
    signal reset(id: int)

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Repeater {
        model: Pipewire.nodes.values.filter(e => e.isSink && !e.isStream)

        RowLayout {
            id: col
            required property PwNode modelData
            width: parent.width
            PwObjectTracker {
                objects: [col.modelData]
            }

            BRadio {
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 10
                active: root.defaultSinkId == col.modelData.id
                onClicked: {
                    if (active) {
                        root.reset(col.modelData.id);
                        Pipewire.preferredDefaultAudioSink = col.modelData;
                    }
                }
                Component.onCompleted: {
                    root.onReset.connect(id => active = id == col.modelData.id);
                }
            }

            Column {
                Layout.fillWidth: true

                Layout.leftMargin: 10
                Layout.rightMargin: 10
                BText {
                    text: col.modelData.description
                    elide: Text.ElideRight
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                BSlider {
                    id: slider
                    width: parent.width
                    value: col.modelData.audio.volume
                    onValueChanged: col.modelData.audio.volume = value
                    withAura: false
                }
            }
        }
    }

    Item {
        height: 20
        width: parent.width
    }

    Repeater {
        model: Pipewire.nodes.values.filter(e => !e.isSink && e.isStream)

        Column {
            id: stream
            required property PwNode modelData

            width: root.width

            PwObjectTracker {
                objects: [stream.modelData]
            }

            BText {
                text: `[${parent.modelData.properties["application.name"]}] ` + (parent.modelData.properties["media.name"] ?? parent.modelData.description)
                elide: Text.ElideRight
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
            }

            BSlider {
                width: parent.width
                value: parent.modelData.audio.volume
                onValueChanged: parent.modelData.audio.volume = value
            }
        }
    }

    Item {
        height: 20
        width: parent.width
    }

    Repeater {
        model: Pipewire.nodes.values.filter(e => !e.isSink && !e.isStream && e.audio)

        Column {
            id: source
            required property PwNode modelData

            width: root.width

            PwObjectTracker {
                objects: [source.modelData]
            }

            BText {
                text: parent.modelData.properties["media.name"] ?? parent.modelData.description
                elide: Text.ElideRight
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
            }

            BSlider {
                width: parent.width
                value: parent.modelData.audio.volume
                onValueChanged: parent.modelData.audio.volume = value
            }
        }
    }
}
