import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Mpris
import "root:base"
import "root:provider"
import QtQuick.Effects
import "root:widgets/MprisBig"

PopupWindow {
    id: audioman
    anchor {
        rect.x: lbar.width * 1.2
        window: lbar
    }

    color: "transparent"
    width: screen?.width ?? display.width
    height: screen?.height ?? display.height
    visible: false

    MouseArea {
        anchors.fill: parent
        onClicked: audioman.visible = false

        BRectangle {
            id: display

            x: lbar.width * 1.2
            y: lbar.height * 0.2

            width: 500
            height: 600

            Image {
                id: background
                anchors.fill: parent
                source: Player.current?.trackArtUrl ?? ""
                Layout.alignment: Qt.AlignHCenter
                visible: true
            }

            MultiEffect {
                autoPaddingEnabled: false
                source: background
                anchors.fill: background
                blurEnabled: true
                blurMax: 64
                blurMultiplier: 2
                blur: 1
                brightness: -0.15
            }

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
