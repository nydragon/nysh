import QtQuick.Layouts
import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Widgets
import "root:provider"
import "root:base"
import QtQuick.Effects
import Quickshell.Services.Mpris

ColumnLayout {
    id: mprisWidget
    Layout.alignment: Qt.AlignHCenter
    Layout.fillWidth: true
    visible: Player.current ?? false

    Label {
        text: `${Player.current?.trackTitle ?? ""}`
        Layout.alignment: Qt.AlignHCenter
        color: "white"
        font.pixelSize: 18
        Layout.maximumWidth: mprisWidget.width
    }

    Label {
        text: `${Player.current?.trackAlbum ?? ""} by ${Player.current?.trackArtists}`
        Layout.alignment: Qt.AlignHCenter
        color: "white"
        font.pixelSize: 14
        Layout.maximumWidth: mprisWidget.width
    }

    RowLayout {
        Layout.fillWidth: true
        PlayerSwitcherButton {
            onClicked: Player.prev()
            Layout.alignment: Qt.AlignLeft
            Layout.fillHeight: true
            Layout.preferredWidth: 50
            visible: Player.all.length > 1
        }
        Item {
            Layout.fillWidth: true
        }

        BRoundedImage {
            source: Player.current?.trackArtUrl ?? ""
            radius: 20
            border.width: 2
            color: "black"
        }

        Item {
            Layout.fillWidth: true
        }
        PlayerSwitcherButton {
            onClicked: Player.next()
            Layout.alignment: Qt.AlignRight
            Layout.fillHeight: true
            Layout.preferredWidth: 50
            visible: Player.all.length > 1
        }
    }

    RowLayout {
        // Mpris Player Controls
        Layout.alignment: Qt.AlignHCenter

        BIconButton {
            property var map: [ //
                ["media-repeat-none", MprisLoopState.None] //
                , ["media-repeat-single", MprisLoopState.Track]//
                , ["media-playlist-repeat", MprisLoopState.Playlist] //
            ]
            property int index: map.findIndex(e => e[1] === Player.current?.loopState)
            source: Quickshell.iconPath(map[index][0])
            onClicked: {
                const ind = (index + 1) % map.length;
                Player.current.loopState = map[ind][1];
            }
        }
        BIconButton {
            source: Quickshell.iconPath("media-seek-backward")
            onClicked: Player.current.previous()
        }
        BIconButton {
            source: Quickshell.iconPath(Player.isPlaying ? "media-playback-pause" : "media-playback-start")
            onClicked: Player.current.togglePlaying()
        }
        BIconButton {
            source: Quickshell.iconPath("media-seek-forward")
            onClicked: Player.current.next()
        }
        BIconButton {
            visible: Player.current?.shuffleSupported ?? false
            source: Quickshell.iconPath(Player.current?.shuffle ? "media-playlist-shuffle" : "media-playlist-normal")
            onClicked: Player.current.shuffle = !Player.current?.shuffle
        }
    }
}
