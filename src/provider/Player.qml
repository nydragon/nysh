pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: player
    property MprisPlayer current: player.all[player.index]
    property var all: Mpris.players.values
    property int index: {
        const ind = Mpris.players.values.findIndex(p => p.playbackState === MprisPlaybackState.Playing);
        return ind >= 0 ? ind : 0;
    }
    property var next: () => {
        player.index = (player.index + 1) % all.length;
    }
    property var prev: () => {
        const newInd = player.index - 1;
        player.index = newInd < 0 ? all.length - 1 : newInd;
    }

    property bool isPlaying: current?.playbackState === MprisPlaybackState.Playing
}
