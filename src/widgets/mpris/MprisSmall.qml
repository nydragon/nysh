pragma ComponentBehavior: Bound

import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Mpris
import Quickshell
import "../../base"

BRectangle {
    id: mprisSmall
    Layout.fillWidth: true
    height: 200

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
            required property int index
            required property var modelData
            property MprisPlayer player: modelData

            visible: card.player?.trackTitle

            width: mprisSmall.width
            height: mprisSmall.height
            radius: 15

            property string albumArt: {
                if (card.player?.trackArtUrl?.length)
                    card.player?.trackArtUrl;
                else
                    Quickshell.iconPath(DesktopEntries.byId(card.player?.desktopEntry).icon);
            }

            BlurredImage {
                source: albumArt
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
                    source: albumArt
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
    }
}
