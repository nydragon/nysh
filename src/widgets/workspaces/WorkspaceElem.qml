import QtQuick
import QtQuick.Layouts
import "../../provider"

Rectangle {
    id: root

    required property int wnum

    property bool hovered: false
    property bool active: workspaces.active === wnum || hovered
    property int activeMargin: 3
    property int inactiveMargin: 5

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: inactiveMargin
    Layout.leftMargin: inactiveMargin

    color: Colors.data.colors.dark.on_surface_variant
    radius: 10

    Behavior on color {
        ColorAnimation {
            duration: 1000
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: () => {
            root.hovered = true;
        }
        onExited: () => {
            root.hovered = false;
        }
        onClicked: () => {
            workspaces.switchWorkspace(parent.wnum);
        }
    }

    states: State {
        name: "focused"
        when: root.active
        PropertyChanges {
            target: root
        }
    }

    transitions: Transition {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 50
        }
    }
}
