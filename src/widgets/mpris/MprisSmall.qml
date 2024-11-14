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

    visible: Player.current ?? false

    BlurredImage {
        source: Player.current?.trackArtUrl ?? ""
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
            source: Player.current?.trackArtUrl ?? ""
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
                text: Player.current?.trackTitle ?? "Unknown Track"
                color: "white"
                Layout.alignment: Qt.AlignCenter
                Layout.maximumWidth: parent.width
                elide: Text.ElideRight
            }

            Text {
                text: Player.current?.trackAlbum ?? "Unknown Album"
                color: "white"
                Layout.alignment: Qt.AlignCenter
                Layout.maximumWidth: parent.width
                elide: Text.ElideRight
            }

            Text {
                text: Player.current?.trackAlbumArtist ?? "Unknown Artist"
                color: "white"
                Layout.alignment: Qt.AlignCenter
                Layout.maximumWidth: parent.width
                elide: Text.ElideRight
            }

            RowLayout {
                Layout.alignment: Qt.AlignCenter
                BIconButton {
                    source: Quickshell.iconPath("media-seek-backward")
                    onClicked: Player.current.previous()
                    size: 20
                }
                BIconButton {
                    source: Quickshell.iconPath(Player.isPlaying ? "media-playback-pause" : "media-playback-start")
                    onClicked: Player.current.togglePlaying()
                    size: 20
                }

                BIconButton {
                    source: Quickshell.iconPath("media-seek-forward")
                    onClicked: Player.current.next()
                    size: 20
                }
            }

            Slider {
                id: slider
                Layout.fillWidth: true
                Layout.minimumWidth: 10
                Layout.minimumHeight: 3
                from: 0
                to: Player.current?.length ?? 0
                value: Player.current?.position ?? 0
                enabled: (Player.current?.canSeek && Player.current?.positionSupported) ?? false

                onMoved: {
                    if (Player.current)
                        Player.current.position = value;
                }

                Component.onCompleted: {
                    const con = () => mprisSmall.player?.positionChanged.connect(() => {
                            slider.value = Player.current?.position;
                        });
                    con();
                    Player.currentChanged.connect(() => {
                        con();
                    });
                }

                FrameAnimation {
                    // only emit the signal when the position is actually changing.
                    running: Player.current?.playbackState == MprisPlaybackState.Playing
                    // emit the positionChanged signal every frame.
                    onTriggered: Player.current?.positionChanged()
                }
            }
        }
    }
}
