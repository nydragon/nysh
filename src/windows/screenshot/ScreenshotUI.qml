import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
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
        anchors.centerIn: parent

        ModeButton {
            activeOn: Screenshot.Mode.Window
            source: "root:assets/window-symbolic.svg"
        }

        ModeButton {
            activeOn: Screenshot.Mode.Region
            source: "root:assets/selection-symbolic.svg"
        }

        ModeButton {
            activeOn: Screenshot.Mode.Monitor
            source: "root:assets/display-symbolic.svg"
        }
    }

    component ModeButton: BIconButton {
        required property int activeOn
        readonly property bool matchingMode: NyshState.screenshot.mode === activeOn

        onMatchingModeChanged: active = matchingMode
        height: 50
        width: 50
        onClicked: NyshState.screenshot.mode = activeOn
        anchors.verticalCenter: parent.verticalCenter
        toggleable: true
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
