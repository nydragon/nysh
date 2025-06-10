pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    property alias data: file.adapter

    FileView {
        id: file
        path: Quickshell.env("HOME") ? `${Quickshell.env("HOME")}/.config/nysh/colours.json` : ""
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        adapter: JsonAdapter {
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
                    property string error
                    property string on_error
                }
            }
        }
    }
}
