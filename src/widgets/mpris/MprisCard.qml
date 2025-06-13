import QtQuick.Effects
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Mpris
import Quickshell
import "../../base"
import "../../provider"

BRectangle {
    id: card
    required property int index
    required property var modelData
    property MprisPlayer player: modelData

    width: 400
    height: 200
    radius: 15

    property string albumArt: {
        if (card.player?.trackArtUrl?.length)
            return card.player?.trackArtUrl;
        else {
            const icon = DesktopEntries.byId(card.player?.desktopEntry)?.icon;
            return icon ? Quickshell.iconPath(icon) : "";
        }
    }

    BlurredImage {
        visible: card.albumArt?.length > 0
        source: card.albumArt
        anchors.fill: parent
        anchors.margins: 3
        radius: parent.radius

        layer.enabled: true
        layer.effect: MultiEffect {
            autoPaddingEnabled: true
            shadowBlur: 0.2
            shadowColor: Colors.data.colors.dark.shadow
            shadowEnabled: true
        }
    }

    RowLayout {
        anchors.fill: parent
        clip: true

        BRoundedImage {
            id: im
            color: "transparent"
            source: card.albumArt
            radius: 15
            Layout.margins: 20
            Layout.preferredWidth: parent.height - (Layout.margins * 2)
            Layout.preferredHeight: parent.height - (Layout.margins * 2)
            Layout.maximumWidth: {
                const mWidth = parent.width - (Layout.margins * 2);
                return mWidth > 0 ? mWidth : 0;
            }
            Layout.fillHeight: true

            layer.enabled: true
            layer.effect: MultiEffect {
                autoPaddingEnabled: true
                shadowBlur: 1.0
                shadowColor: Colors.data.colors.dark.shadow
                shadowEnabled: true
            }
        }

        ColumnLayout {
            Layout.maximumWidth: parent.width / 2
            Layout.fillWidth: true
            clip: true

            BText {
                text: card.player?.trackTitle ?? "Unknown Track"
                Layout.alignment: Qt.AlignCenter
                Layout.maximumWidth: parent.width
                elide: Text.ElideRight
            }

            BText {
                text: card.player?.trackAlbum ?? "Unknown Album"
                Layout.alignment: Qt.AlignCenter
                Layout.maximumWidth: parent.width
                elide: Text.ElideRight
            }

            BText {
                text: card.player?.trackAlbumArtist ?? "Unknown Artist"
                Layout.alignment: Qt.AlignCenter
                Layout.maximumWidth: parent.width
                elide: Text.ElideRight
            }

            RowLayout {
                Layout.alignment: Qt.AlignCenter
                BTextButton {
                    onClicked: card.player?.previous()
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    text: ""
                }

                BTextButton {
                    onClicked: card.player?.togglePlaying()
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    text: card.player?.playbackState === MprisPlaybackState.Playing ? "" : ""
                }

                BTextButton {
                    onClicked: card.player?.next()
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    text: ""
                }
            }

            BSlider {
                id: slider
                Layout.fillWidth: true
                Layout.minimumWidth: 10
                Layout.minimumHeight: 3
                from: 0
                to: card.player?.length ?? 0
                value: card.player?.position ?? 0
                enabled: (card.player?.canSeek && card.player?.positionSupported) ?? false

                onMoved: {
                    if (card.player) {
                        card.player.position = value;
                        value = card.player.position;
                    }
                }

                FrameAnimation {
                    // only emit the signal when the position is actually changing.
                    running: card.player?.playbackState == MprisPlaybackState.Playing
                    // emit the positionChanged signal every frame.
                    onTriggered: card.player?.positionChanged()
                }
            }
        }
    }
}
