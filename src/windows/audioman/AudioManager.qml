import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:base"

PopupWindow {
    anchor {
        rect.x: lbar.width * 1.2
        rect.y: lbar.width * 0.2
        window: lbar
    }

    color: "transparent"
    width: 500
    height: 300
    visible: false

    BRectangle {
        anchors.fill: parent

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
