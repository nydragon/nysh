pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../../base"
import Quickshell.Services.Notifications

MouseArea {
    id: toast
    readonly property int lifetime: 5000
    property int countdownTime: lifetime

    required property string appName
    required property string summary
    required property string body
    required property string appIcon
    required property string image
    required property NotificationUrgency urgency
    required property bool hasActionIcons
    required property var actions
    required property int index
    Component.onCompleted: () => console.log(toast.actions.values)

    function close(): void {
        popupcol.model.remove(toast.index, 1);
    }

    hoverEnabled: true
    height: box.height
    width: popupcol.width

    BRectangle {
        id: box
        width: parent.width
        height: header.height + actions.height + test.height + (5 * 3)

        clip: true

        Item {
            id: inner
            anchors.margins: 5
            anchors.fill: parent

            RowLayout {
                id: header
                width: parent.width
                height: 25

                IconImage {
                    source: toast.appIcon ? Quickshell.iconPath(toast.appIcon) : ""
                    height: parent.height
                    width: height
                    visible: toast.appIcon
                }

                Text {
                    text: (toast.appIcon ? " " : toast.appName + ": ") + toast.summary
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    font.pointSize: 12.5
                }

                Item {
                    Layout.fillHeight: true
                    Layout.rightMargin: 16
                    Button {
                        onClicked: toast.close()
                        height: 16
                        width: 16
                    }
                }
            }

            Rectangle {
                id: test
                width: parent.width
                anchors.top: header.bottom
                height: 60
                clip: true
                property int maxHeight: 0
                color: "transparent"

                Text {
                    id: text
                    anchors.topMargin: 5
                    text: toast.body
                    width: parent.width
                    height: parent.height
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    font.pointSize: 12.5
                    Component.onCompleted: () => {
                        if (text.implicitHeight < test.height) {
                            test.height = text.implicitHeight;
                        }
                        test.maxHeight = text.implicitHeight;
                    }
                }

                states: State {
                    name: "expand"
                    when: toast.containsMouse
                    PropertyChanges {
                        target: test
                        height: test.maxHeight
                    }
                }

                transitions: Transition {
                    NumberAnimation {
                        properties: "width,height"
                        duration: 50
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            RowLayout {
                id: actions
                width: parent.width
                anchors.top: test.bottom
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                Repeater {
                    model: toast.actions

                    delegate: ToastAction {
                        required property var modelData
                        notifAction: modelData
                        hasIcons: toast.hasActionIcons
                    }
                }

                visible: toast?.actions ? true : false
            }

            states: State {
                name: "expand"
                when: toast.containsMouse
                PropertyChanges {
                    target: box
                    height: test.height + header.height + actions.height + 15
                }
            }

            transitions: Transition {
                NumberAnimation {
                    properties: "width,height"
                    duration: 50
                    easing.type: Easing.InOutQuad
                }
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
