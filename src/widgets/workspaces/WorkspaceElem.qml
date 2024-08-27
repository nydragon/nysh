import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: elem
    required property int workspaceNum
    required property int activeWorkspaceNum
    property bool focused: active
    property bool active: workspaceNum == activeWorkspaceNum
    property int focusedMargin: 3
    property int margin: (focused || active) ? focusedMargin : 5

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: margin
    Layout.leftMargin: margin

    color: "black"
    radius: 10

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: () => {
            elem.focused = true;
        }

        onExited: () => {
            elem.focused = active ?? false;
        }
    }

    states: State {
        name: "focused"
        when: focused || active
        PropertyChanges {
            target: elem
            Layout.rightMargin: focusedMargin
            Layout.leftMargin: focusedMargin
        }
    }

    transitions: Transition {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 50
        }
    }
}
