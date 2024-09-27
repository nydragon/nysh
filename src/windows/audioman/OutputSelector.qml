import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Services.Pipewire

ColumnLayout {
    ComboBox {
        id: select
        property var creator: Qt.createComponent("OutputElem.qml")
        property var currentNode: select.model[select.currentIndex]

        Layout.fillWidth: true
        textRole: "name"
        model: Pipewire.nodes.values.filter(e => e.isSink && !e.isStream).map(m => {
            return creator.createObject(select, {
                node: m
            });
        })

        onActivated: i => {
            Pipewire.preferredDefaultAudioSink = model[i].node;
            //makeDefault.running = true;
        }

        currentIndex: select.model.findIndex(e => e?.node?.id == Pipewire.defaultAudioSink?.id)

        Process {
            id: makeDefault
            command: ["pactl", "set-default-sink", select.model[select.currentIndex]?.node?.name]
            running: false
        }
    }

    Slider {
        Layout.fillWidth: true
        value: select.model[select.currentIndex]?.node.audio.volume ?? 0
        onValueChanged: select.model[select.currentIndex].node.audio.volume = value
    }
}
