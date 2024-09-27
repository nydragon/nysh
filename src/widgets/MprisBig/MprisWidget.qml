import QtQuick.Layouts
import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Widgets
import "root:provider"
import "root:base"
import QtQuick.Effects

ColumnLayout {
    Layout.alignment: Qt.AlignHCenter
    Layout.fillWidth: true
    visible: Player.current ?? false

    Label {
        text: `${Player.current?.trackTitle ?? ""}`
        Layout.alignment: Qt.AlignHCenter
        color: "white"
        font.pixelSize: 18
    }

    Label {
        text: `${Player.current?.trackAlbum ?? ""} by ${Player.current?.trackArtists}`
        Layout.alignment: Qt.AlignHCenter
        color: "white"
        font.pixelSize: 14
    }

    RowLayout {
        Layout.fillWidth: true
        PlayerSwitcherButton {
            onClicked: Player.prev()
            Layout.alignment: Qt.AlignLeft
            Layout.fillHeight: true
            Layout.preferredWidth: 50
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
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter

        BIconButton {
            source: Quickshell.iconPath("media-seek-backward")
            onClicked: Player.current.previous()
        }
        BIconButton {
            source: Quickshell.iconPath(Player.isPlaying ? "media-playback-start" : "media-playback-pause")
            onClicked: Player.current.togglePlaying()
        }
        BIconButton {
            source: Quickshell.iconPath("media-seek-forward")
            onClicked: Player.current.next()
        }
    }
}
