pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    property alias data: file.jsonAdapter

    FileView {
        id: file
        path: NyshState.home ? `${NyshState.home}/.config/nysh/colours.json` : ""

        // when changes are made on disk, reload the file's content
        watchChanges: true
        onFileChanged: reload()

        // when changes are made to properties in the adapter, save them
        onAdapterUpdated: writeAdapter()

        adapter: jsonAdapter

        property JsonAdapter jsonAdapter: JsonAdapter {
            property JsonObject colors: JsonObject {
                property JsonObject dark: JsonObject {
                    property string on_primary
                    property string primary
                    property string primary_container
                    property string surface
                    property string surface_container
                    property string secondary_container
                    property string secondary
                    property string on_secondary_container
                    property string on_surface_variant
                    property string on_surface
                    property string shadow
                    property string surface_container_high
                    property string outline
                }
            }
        }
    }
}
