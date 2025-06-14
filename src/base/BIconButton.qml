pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import "../provider"

MouseArea {
    id: root

    required property string source

    readonly property var colors: Colors.data.colors.dark
    readonly property int animationDuration: 100
    readonly property int radius: root.toggleable && root.active ? Math.max(width, height) / 6 : Math.max(width, height)

    property bool toggleable: false
    property bool active: false

    onClicked: active = !active
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    clip: true

    BRectangle {
        color: root.toggleable && !root.active ? root.colors.surface_container : root.colors.primary
        radius: root.radius
        anchors.fill: parent

        Behavior on radius {
            NumberAnimation {
                duration: root.animationDuration
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: root.animationDuration
            }
        }
    }

    BRectangle {
        color: root.toggleable && !root.active ? root.colors.on_surface_variant : root.colors.on_primary
        visible: root.containsMouse
        radius: root.radius
        anchors.fill: parent
        opacity: root.containsPress ? 0.18 : 0.08

        Behavior on color {
            ColorAnimation {
                duration: root.animationDuration
            }
        }
    }

    IconImage {
        anchors.fill: parent
        anchors.margins: 5
        source: root.source
        layer.enabled: true
        layer.effect: MultiEffect {
            colorization: 1
            colorizationColor: root.toggleable && !root.active ? root.colors.on_surface_variant : root.colors.on_primary
        }
    }
}
