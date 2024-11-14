import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../base"
import "../../provider"
import "../../widgets/MprisBig"

PanelWindow {
    id: audioman
    anchors {
        top: true
        left: true
    }

    color: "transparent"
    width: screen?.width ?? display.width
    height: screen?.height ?? display.height
    visible: false

    MouseArea {
        anchors.fill: parent
        onClicked: audioman.visible = false

        BlurredImage {
            id: display
            x: 10
            y: 10
            width: 500
            height: 600
            radius: 10
            source: Player.current?.trackArtUrl ?? ""
            color: "#BD93F9"

            ScrollView {
                id: test
                anchors.fill: parent
                contentWidth: availableWidth

                ColumnLayout {
                    id: p
                    // BUG: We access nodes before they are initialized
                    anchors.fill: parent
                    anchors.margins: 10

                    MprisWidget {}

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
}
