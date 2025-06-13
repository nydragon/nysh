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
        anchors.verticalCenter: parent.verticalCenter

        ModeButton {
            activeOn: Screenshot.Mode.Window
            iconSource: "root:assets/window-symbolic.svg"
        }

        ModeButton {
            activeOn: Screenshot.Mode.Region
            iconSource: "root:assets/selection-symbolic.svg"
        }

        ModeButton {
            activeOn: Screenshot.Mode.Monitor
            iconSource: "root:assets/display-symbolic.svg"
        }
    }

    component ModeButton: BMButton {
        id: button
        required property int activeOn
        required property string iconSource
        readonly property bool matchingMode: NyshState.screenshot.mode === activeOn

        onMatchingModeChanged: active = matchingMode

        height: 50
        width: 50
        text: ""
        onClicked: NyshState.screenshot.mode = activeOn
        anchors.verticalCenter: parent.verticalCenter
        toggleable: true

        IconImage {
            anchors.fill: parent
            anchors.margins: 5
            source: button.iconSource
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
