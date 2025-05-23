import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../provider"

PanelWindow {
    id: audioman
    anchors {
        top: true
        left: true
    }

    color: Colors.data.colors.dark.surface

    implicitWidth: 500
    implicitHeight: 600
    visible: false

    MouseArea {
        anchors.fill: parent
        onClicked: audioman.visible = false

        width: 500
        height: 600

        ScrollView {
            id: test
            anchors.fill: parent
            contentWidth: availableWidth

            ColumnLayout {
                id: p
                // BUG: We access nodes before they are initialized
                anchors.fill: parent
                anchors.margins: 10

                OutputSelector {}

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
