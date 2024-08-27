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
                // BUG: We access nodes before they are initialized
                anchors.fill: parent
                anchors.margins: 10

                Repeater {
                    model: Pipewire.nodes.values.filter(e => e.isSink)

                    AudioEntry {
                        required property PwNode modelData
                        node: modelData
                    }
                }

                Rectangle {
                    height: 2
                    color: "black"
                    Layout.fillWidth: true
                    radius: 10
                }

                Repeater {
                    model: Pipewire.nodes.values.filter(e => e.isStream)

                    AudioEntry {
                        required property PwNode modelData
                        node: modelData
                    }
                }
            }
        }
    }
}
