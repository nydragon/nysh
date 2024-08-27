import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: elem

    required property bool focused
    required property int wnum

    property bool hovered: false
    property bool active: focused || hovered
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
            elem.hovered = true;
        }

        onExited: () => {
            elem.hovered = false;
        }
        onClicked: () => {
            switcher.running = true;
        }
    }

    Process {
        id: switcher
        command: ["swaymsg", "workspace", `${wnum}`]
    }

    states: State {
        name: "focused"
        when: active
        PropertyChanges {
            target: elem
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
