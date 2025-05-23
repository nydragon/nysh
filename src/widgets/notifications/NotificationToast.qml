pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../../base"
import "../../provider"
import Quickshell.Services.Notifications

MouseArea {
    id: toast

    required property Notification notif

    property int actionHeight: 30
    property int expansionSpeed: 200
    property bool showTimeBar: false

    property string body
    property string appName
    property string summary
    property string appIcon

    Component.onCompleted: {
        body = notif?.body ?? "";
        appName = notif?.appName ?? "";
        summary = notif?.summary ?? "";
        appIcon = notif?.appIcon ?? "";
    }

    height: box.height
    hoverEnabled: true

    signal close

    TextEdit {
        id: textEdit
        visible: false
    }

    BRectangle {
        id: box
        width: parent.width
        height: header.height + actions.implicitHeight + bodyBox.height + (5 * 3)

        clip: true
        color: Colors.data.colors.dark.surface
        Item {
            id: inner
            anchors.margins: 5
            anchors.fill: parent

            RowLayout {
                id: header
                width: parent.width
                height: 40

                IconImage {
                    source: toast.appIcon ? Quickshell.iconPath(toast.appIcon) : ""
                    height: parent.height
                    width: height
                    visible: toast.appIcon ?? false
                }

                BText {
                    text: `${toast.appIcon ? "" : `${toast.appName}:`} ${toast.summary}`
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    font.pointSize: 12.5
                }

                BTextButton {
                    onClicked: () => {
                        textEdit.text = toast.body;
                        textEdit.selectAll();
                        textEdit.copy();
                    }
                    text: ""
                    height: 30
                    width: 30
                }

                BTextButton {
                    id: d
                    onClicked: toast.close()
                    height: 30
                    width: 30
                    text: ""
                }
            }

            Rectangle {
                id: bodyBox
                width: parent.width
                anchors.top: header.bottom
                height: 60
                clip: true
                property int maxHeight: 0
                color: "transparent"

                BText {
                    id: text
                    anchors.topMargin: 5
                    text: toast.body ?? ""
                    width: parent.width
                    height: parent.height
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    font.pointSize: 12.5

                    onImplicitHeightChanged: {
                        if (text.implicitHeight < bodyBox.height) {
                            bodyBox.height = text.implicitHeight;
                        }
                    }

                    Component.onCompleted: () => {
                        bodyBox.maxHeight = Qt.binding(() => text.implicitHeight);
                    }
                }

                states: State {
                    name: "expand"
                    when: toast.containsMouse
                    PropertyChanges {
                        target: bodyBox
                        height: bodyBox.maxHeight
                    }
                }

                transitions: Transition {
                    NumberAnimation {
                        properties: "height"
                        duration: toast.expansionSpeed
                    }
                }
            }

            GridLayout {
                id: actions
                width: parent.width
                anchors.top: bodyBox.bottom
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                columns: toast.notif?.actions.length < 6 ? toast.notif?.actions.length : 4
                Repeater {
                    id: rep
                    model: toast.notif?.actions

                    delegate: NotificationToastAction {
                        required property var modelData
                        notifAction: modelData
                        hasIcons: toast.notif?.hasActionIcons ?? false
                        height: toast.actionHeight
                        Layout.fillWidth: true
                    }
                }
                visible: toast.notif?.actions.length ?? false
            }
        }

        NumberAnimation on width {
            duration: toast.expansionSpeed
        }

        Rectangle {
            id: timeBar
            visible: toast.showTimeBar
            anchors.margins: 2
            anchors.bottom: box.bottom
            anchors.right: box.right
            width: box.width - box.border.width - anchors.margins
            height: 2
            bottomLeftRadius: box.radius
            bottomRightRadius: box.radius
            color: {
                switch (toast.notif?.urgency) {
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

            NumberAnimation on width {
                to: 0
                duration: Config.notifications.toastDuration
                paused: toast.containsMouse && timeBar.visible
                running: timeBar.visible
            }
        }
    }
}
