pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: config

    property alias data: file.jsonAdapter

    FileView {
        id: file
        path: NyshState.home ? `${NyshState.home}/.config/nysh/config.json` : ""

        // when changes are made on disk, reload the file's content
        watchChanges: true
        onFileChanged: reload()

        // when changes are made to properties in the adapter, save them
        onAdapterUpdated: writeAdapter()
        adapter: jsonAdapter

        property JsonAdapter jsonAdapter: JsonAdapter {
            property int colourFadeSpeed: 1000
            property JsonObject notifications: JsonObject {
                property int toastDuration: 5000
            }
        }
    }
}
