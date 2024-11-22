pragma ComponentBehavior: Bound

import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Mpris
import Quickshell
import "../../base"
import "../../provider"

BRectangle {
    id: mprisSmall
    Layout.fillWidth: true
    Layout.preferredHeight: 200

    radius: 15
    clip: true
    border.color: "transparent"
    visible: list.count

    ListView {
        id: list
        anchors.fill: parent
        model: Mpris.players
        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        spacing: 10
        delegate: BRectangle {
            id: card
            required property var modelData
            property MprisPlayer player: modelData

            width: mprisSmall.width
            height: mprisSmall.height
            radius: 15

            BlurredImage {
                source: card.player?.trackArtUrl ?? ""
                anchors.fill: parent
                radius: parent.radius
            }

            RowLayout {
                anchors.fill: parent
                clip: true
                BRoundedImage {
                    id: im
                    color: "transparent"
                    visible: false
                    source: card.player?.trackArtUrl ?? ""
                    radius: 15
                }

                MultiEffect {
                    id: effect
                    source: im
                    autoPaddingEnabled: true
                    shadowBlur: 1.0
                    shadowColor: 'black'
                    shadowEnabled: true
                    Layout.margins: 20
                    Layout.preferredWidth: parent.height - (Layout.margins * 2)
                    Layout.preferredHeight: parent.height - (Layout.margins * 2)
                    Layout.maximumWidth: {
                        const mWidth = parent.width - (Layout.margins * 2);
                        return mWidth > 0 ? mWidth : 0;
                    }
                    Layout.fillHeight: true
                }

                ColumnLayout {
                    Layout.maximumWidth: parent.width / 2
                    Layout.fillWidth: true
                    clip: true

                    Text {
                        text: card.player?.trackTitle ?? "Unknown Track"
                        color: "white"
                        Layout.alignment: Qt.AlignCenter
                        Layout.maximumWidth: parent.width
                        elide: Text.ElideRight
                    }

                    Text {
                        text: card.player?.trackAlbum ?? "Unknown Album"
                        color: "white"
                        Layout.alignment: Qt.AlignCenter
                        Layout.maximumWidth: parent.width
                        elide: Text.ElideRight
                    }

                    Text {
                        text: card.player?.trackAlbumArtist ?? "Unknown Artist"
                        color: "white"
                        Layout.alignment: Qt.AlignCenter
                        Layout.maximumWidth: parent.width
                        elide: Text.ElideRight
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignCenter
                        BIconButton {
                            source: Quickshell.iconPath("media-seek-backward")
                            onClicked: card.player?.previous()
                            size: 20
                        }
                        BIconButton {
                            source: Quickshell.iconPath(card.player?.playbackState === MprisPlaybackState.Playing ? "media-playback-pause" : "media-playback-start")
                            onClicked: card.player?.togglePlaying()
                            size: 20
                        }

                        BIconButton {
                            source: Quickshell.iconPath("media-seek-forward")
                            onClicked: card.player?.next()
                            size: 20
                        }
                    }

                    Slider {
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
    }
}
