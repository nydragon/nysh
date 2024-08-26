import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

RowLayout {
    required property PwNode node

    // bind the node so we can read its properties
    PwObjectTracker {
        objects: [node]
    }

    //Component.onCompleted: console.log(JSON.stringify(node.properties, null, 2))

    Image {
        source: {
            const hasIcon = !!node.properties["application.icon-name"] ?? false;
            console.log(hasIcon);
            const getFallback = () => node.isStream ? "root:/../assets/folder-music.svg" : "root:/../assets/audio-volume-high.svg";
            const icon = hasIcon ? `image://icon/${node.properties["application.icon-name"]}` : getFallback();
            icon;
        }

        //sourceSize.width: 40
        //sourceSize.height: 40
        fillMode: Image.PreserveAspectFit

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumWidth: 40
        Layout.maximumHeight: parent.height

        sourceSize.width: 40
        sourceSize.height: 40
        //width: 40
        //height: 40
        Component.onCompleted: console.log(`width: ${paintedWidth}, height: ${paintedHeight}`)
    }

    ColumnLayout {
        RowLayout {
            id: b
            spacing: 6
            Layout.preferredHeight: 30

            Text {
                text: node.properties["media.name"] ?? node.description
            }

            Button {
                visible: node.isSink
                width: 10
                checkable: true
                Image {
                    source: node.audio.muted ? "root:/../assets/mute.png" : "root:/../assets/speaker.png"
                    height: parent.height * (2 / 3)

                    anchors.centerIn: parent

                    fillMode: Image.PreserveAspectFit
                }
                onClicked: node.audio.muted = !node.audio.muted
            }

            Button {
                visible: node.isSink
                text: "default"
            }
        }
        RowLayout {
            Label {
                Layout.preferredWidth: 50
                text: `${Math.floor(node.audio.volume * 100)}%`
            }

            Slider {
                Layout.fillWidth: true
                value: node.audio.volume
                onValueChanged: node.audio.volume = value
            }
        }
    }
}
