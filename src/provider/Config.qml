pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property alias data: file.adapter

    FileView {
        id: file
        path: NyshState.home ? `${NyshState.home}/.config/nysh/config.json` : ""
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        adapter: JsonAdapter {
            property int colourFadeSpeed: 1000
            property JsonObject notifications: JsonObject {
                property int toastDuration: 5000
            }
            property JsonObject sizes: JsonObject {
                property int barWidth: 35
            }
        }
    }
}
