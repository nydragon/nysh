import QtQuick
import QtQuick.Layouts
import "../../provider"

Rectangle {
    id: root

    required property int wnum

    property bool hovered: false
    property bool active: workspaces.active === wnum || area.containsMouse
    property int activeMargin: 3
    property int inactiveMargin: 5

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: active ? activeMargin : inactiveMargin
    Layout.leftMargin: active ? activeMargin : inactiveMargin

    color: Colors.data.colors.dark.on_surface_variant
    radius: 10

    Behavior on color {
        ColorAnimation {
            duration: 1000
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        onClicked: workspaces.switchWorkspace(parent.wnum)
    }
}
