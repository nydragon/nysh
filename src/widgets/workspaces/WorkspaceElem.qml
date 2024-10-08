import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

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

    color: "black"
    radius: 10

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
            workspaces.switchWorkspace(wnum);
        }
    }

    states: State {
        name: "focused"
        when: root.active
        PropertyChanges {
            target: root
            Layout.rightMargin: activeMargin
            Layout.leftMargin: activeMargin
        }
    }

    transitions: Transition {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 50
        }
    }
}
