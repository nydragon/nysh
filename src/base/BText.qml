import "../provider"
import QtQuick

Text {
    color: Colors.data.colors.dark.on_surface_variant

    Behavior on color {
        ColorAnimation {
            duration: 1000
        }
    }
}
