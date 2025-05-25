import QtQuick.Effects
import QtQuick
import "../provider"

BRectangle {
    id: root
    property alias focused: area.containsMouse
    property bool toggled: false
    readonly property string normalColor: Colors.data.colors.dark.surface_container
    readonly property string shadowColor: Colors.data.colors.dark.shadow

    layer.enabled: true
    layer.effect: MultiEffect {
        id: effect
        autoPaddingEnabled: true
        shadowBlur: 0.2
        shadowColor: shadowColor
        shadowEnabled: true
        anchors.centerIn: parent
        anchors.fill: parent
    }
    border.color: Colors.data.colors.dark.secondary
    border.width: focused ? 2 : 0
    color: normalColor

    MouseArea {
        id: area
        anchors.fill: parent
        anchors.centerIn: parent
        hoverEnabled: true
        onClicked: root.toggled = !root.toggled
    }
}
