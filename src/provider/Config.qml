pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property alias data: adapter
    property alias notifications: adapter.notifications

    FileView {
        id: file
        path: NyshState.home ? `${NyshState.home}/.config/nysh/config.json` : ""
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter
            property int colourFadeSpeed: 1000
            property JsonObject notifications: JsonObject {
                property int timeout: 5000
            }
            property JsonObject sizes: JsonObject {
                property int barWidth: 35
            }
        }
    }
}
