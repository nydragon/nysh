import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PopupWindow {
    anchor {
        rect.x: 30
        rect.y: 20
    }

    color: "transparent"
    width: 500
    height: 300
    visible: false

    Rectangle {
        anchors.fill: parent
        border.color: "black"
        border.width: 2
        radius: 5
        color: "white"
        ScrollView {
            anchors.fill: parent
            contentWidth: availableWidth

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10

                PwNodeLinkTracker {
                    id: linkTracker
                    node: Pipewire.defaultAudioSink
                }

                AudioEntry {
                    node: Pipewire.defaultAudioSink
                }

                Rectangle {
                    height: 2
                    color: "black"
                    Layout.fillWidth: true
                    radius: 10
                }

                Repeater {
                    // Show all sources, regardless of what sink they are assigned to
                    model: Pipewire.linkGroups

                    AudioEntry {
                        required property PwLinkGroup modelData
                        node: modelData.source
                    }
                }
            }
        }
    }
}
