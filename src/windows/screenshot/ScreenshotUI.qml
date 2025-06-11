import QtQuick
import QtQuick.Effects
import "../../provider"
import "../../base"

BRectangle {
    width: 400
    height: 75
    color: Colors.data.colors.dark.surface_container
    radius: 50
    border.width: 2
    border.color: Colors.data.colors.dark.on_surface_variant
    layer.enabled: true
    layer.effect: MultiEffect {
        id: effect
        autoPaddingEnabled: true
        shadowBlur: 0.2
        shadowColor: shadowColor
        shadowEnabled: true
    }

    BMButton {
        height: 40
        width: 40
        text: "x"
        onClicked: NyshState.screenshot.set(false)
        anchors.margins: 20
        anchors.top: parent.top
        anchors.right: parent.right
    }
}
