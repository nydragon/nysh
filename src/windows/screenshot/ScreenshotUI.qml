import QtQuick
import QtQuick.Effects
import "../../provider"
import "../../provider/state"
import "../../base"

BRectangle {
    id: root

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

    Row {
        anchors.verticalCenter: parent.verticalCenter

        BMButton {
            height: 40
            width: 40
            text: "win"
            onClicked: NyshState.screenshot.mode = Screenshot.Mode.Window
            anchors.verticalCenter: parent.verticalCenter
        }

        BMButton {
            height: 40
            width: 40
            text: "reg"
            onClicked: NyshState.screenshot.mode = Screenshot.Mode.Region
            anchors.verticalCenter: parent.verticalCenter
        }

        BMButton {
            height: 40
            width: 40
            text: "mon"
            onClicked: NyshState.screenshot.mode = Screenshot.Mode.Monitor
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    BMButton {
        height: 40
        width: 40
        text: "x"
        onClicked: NyshState.screenshot.setOpen(false)
        anchors.margins: 20
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
