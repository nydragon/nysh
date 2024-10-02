import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "root:base"
import Quickshell.Services.Notifications

MouseArea {
    id: toast
    property int lifetime: 10000
    property int countdownTime: lifetime

    required property string appName
    required property string summary
    required property string body
    required property string appIcon
    required property string image
    required property NotificationUrgency urgency
    required property int index

    hoverEnabled: true
    height: box.height
    width: box.width

    BRectangle {
        id: box
        height: 26
        width: 200

        BRectangle {
            anchors.fill: parent

            Column {
                anchors.fill: parent
                anchors.margins: 5
                Row {
                    IconImage {
                        source: Quickshell.iconPath(toast.appIcon)
                        height: 16
                        visible: toast.appIcon
                    }

                    Text {
                        text: (toast.appIcon ? " " : toast.appName + ": ") + toast.summary
                    }
                }
                Text {
                    text: toast.body
                    visible: box.state === "expand"
                }
            }
        }

        states: State {
            name: "expand"
            when: toast.containsMouse
            PropertyChanges {
                target: box
                width: 250
                height: 140
            }
        }

        transitions: Transition {
            NumberAnimation {
                properties: "width,height"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }

        Rectangle {
            anchors.margins: 2
            anchors.bottom: box.bottom
            anchors.right: box.right
            width: (box.width - box.border.width - anchors.margins) * (toast.countdownTime / toast.lifetime)
            height: 2
            bottomLeftRadius: box.radius
            bottomRightRadius: box.radius
            color: {
                switch (toast.urgency) {
                case NotificationUrgency.Critical:
                    return "red";
                    break;
                case NotificationUrgency.Normal:
                    return "green";
                    break;
                default:
                    return "white";
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 10
        repeat: !toast.containsMouse
        onTriggered: () => {
            toast.countdownTime -= timer.interval;
            if (toast.countdownTime <= 0) {
                toast.parent.parent.model.remove(toast.index, 1);
                timer.repeat = false;
                timer.running = false;
            }
        }
        running: !toast.containsMouse
    }
}
