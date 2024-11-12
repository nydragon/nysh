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

        BRectangle {
            id: display

            x: 10
            y: 10
            width: 500
            height: 600
            radius: 10

            Image {
                id: background
                anchors.fill: parent
                source: Player.current?.trackArtUrl ?? ""
                Layout.alignment: Qt.AlignHCenter
                visible: false
                anchors.margins: display.border.width - 1
            }

            MultiEffect {
                id: image
                autoPaddingEnabled: false
                source: background
                anchors.fill: background
                blurEnabled: true
                blurMax: 64
                blurMultiplier: 2
                blur: 1
                brightness: -0.15
                contrast: -0.35
                maskEnabled: true
                maskSource: mask
            }

            Item {
                id: mask
                width: image.width
                height: image.height
                layer.enabled: true
                visible: false

                Rectangle {
                    width: image.width
                    height: image.height
                    radius: display.radius
                    color: "black"
                }
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
