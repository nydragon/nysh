import QtQuick
import Quickshell.Services.Mpris
import Quickshell
import "../../base"

BRectangle {
    id: mprisSmall
    height: 200
    width: 400
    radius: 15
    clip: true
    border.color: "transparent"
    visible: list.count

    ListView {
        id: list
        anchors.fill: parent
        model: ScriptModel {
            values: {
                // TODO: fix this ugly shit
                const x = [...Mpris.players.values.filter(player => player.length != 0 && player?.trackTitle != "")];
                x.sort((a, b) => {
                    if (a.isPlaying && b.isPlaying) {
                        return 0;
                    } else if (a.isPlaying && !b.isPlaying) {
                        return -1;
                    } else if (!a.isPlaying && b.isPlaying) {
                        return 1;
                    }
                });

                return x;
            }
        }
        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        spacing: 10
        clip: true
        delegate: MprisCard {
            width: ListView.view.width
            height: ListView.view.height
        }
    }
}
