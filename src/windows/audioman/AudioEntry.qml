import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import Quickshell.Io

RowLayout {
    id: root
    required property PwNode node

    // bind the node so we can read its properties
    PwObjectTracker {
        objects: [root.node]
    }

    Image {
        source: {
            const getFallback = () => node.isStream ? "root:/assets/folder-music.svg" : "root:/assets/audio-volume-high.svg";
            root.node.properties["application.icon-name"] ? `image://icon/${root.node.properties["application.icon-name"]}` : getFallback();
        }

        fillMode: Image.PreserveAspectFit

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumWidth: 40
        Layout.maximumHeight: parent.height

        sourceSize.width: 40
        sourceSize.height: 40
    }

    ColumnLayout {
        RowLayout {
            spacing: 6
            Layout.preferredHeight: 30

            Label {
                id: name
                text: {
                    const app = root.node.isStream ? `[${root.node.properties["application.name"]}] ` : "";
                    return app + (root.node.properties["media.name"] ?? root.node.description);
                }
                color: "white"
                // Cede space to other elements -> don't have stupidly long names destroying the layout
                Layout.maximumWidth: 0
            }

            Item {
                // Padding to move the buttons to the right
                Layout.fillWidth: true
            }

            Button {
                visible: root.node.isSink
                width: 10
                checkable: true
                Image {
                    source: node.audio.muted ? "root:/assets/audio-volume-muted.svg" : "root:/assets/audio-volume-high.svg"
                    height: parent.height * (2 / 3)

                    anchors.centerIn: parent

                    fillMode: Image.PreserveAspectFit
                }
                onClicked: root.node.audio.muted = !root.node.audio.muted
            }
        }

        RowLayout {
            Label {
                Layout.preferredWidth: 50
                text: `${Math.floor(root.node.audio.volume * 100)}%`
                color: "white"
            }

            Slider {
                Layout.fillWidth: true
                value: root.node.audio.volume
                onValueChanged: root.node.audio.volume = value
            }
        }
    }
}
