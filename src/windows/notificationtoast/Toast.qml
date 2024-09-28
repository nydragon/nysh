import QtQuick
import QtQuick.Controls
import Quickshell
import "root:base"

BRectangle {
    id: toast
    color: "#BD93f910"
    height: 50
    width: 200
    property int lifetime: 10000
    property int countdownTime: lifetime

    required property string appName
    required property string summary
    required property int index
    MouseArea {

        anchors.margins: 10
        anchors.fill: parent
        Text {
            text: toast.appName + ": " + toast.summary
        }

        onEntered: () => {
            timer.repeat = false;
        }
        onExited: () => {
            timer.repeat = true;
        }
    }

    Rectangle {
        anchors.margins: 2
        anchors.bottom: toast.bottom
        anchors.right: toast.right
        width: (toast.width - toast.border.width - anchors.margins) * (toast.countdownTime / toast.lifetime)
        height: 2
        bottomLeftRadius: toast.radius
        bottomRightRadius: toast.radius
    }

    Timer {
        id: timer
        interval: 10
        repeat: true
        onTriggered: () => {
            toast.countdownTime -= timer.interval;
            if (toast.countdownTime <= 0) {
                toast.parent.parent.model.remove(toast.index, 1);
                timer.repeat = false;
                timer.running = false;
            }
        }
        running: true
    }
}
