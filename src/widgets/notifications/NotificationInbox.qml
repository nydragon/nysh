import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell

import "../../provider"
import "../../base"

ColumnLayout {
    Layout.preferredHeight: 1000

    Layout.fillHeight: true
    Layout.fillWidth: true

    width: parent.width

    RowLayout {
        Layout.alignment: Qt.AlignRight

        Switch {
            id: sw
            text: qsTr("DnD")
            onClicked: () => {
                NyshState.dndOn = checked;
            }
            checked: NyshState.dndOn
        }

        BButton {
            width: 30
            height: 30
            onClicked: () => {
                Notifications.clearAll();
            }
            Layout.alignment: Qt.AlignRight
            IconImage {
                anchors.fill: parent
                source: Quickshell.iconPath("window-close")
            }
        }
    }

    ListView {
        id: popupcol
        Layout.fillHeight: true
        Layout.fillWidth: true

        clip: true
        spacing: 10
        width: parent.width

        model: Notifications.list

        delegate: NotificationToast {
            id: toast

            required property var modelData
            required property int index

            notif: modelData
            width: ListView.view.width

            onClose: {
                toast.notif.dismiss();
            }
        }

        addDisplaced: Transition {
            NumberAnimation {
                properties: "x,y"
                duration: 100
            }
        }
        remove: Transition {
            PropertyAction {
                property: "ListView.delayRemove"
                value: true
            }
            ParallelAnimation {
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: 200
                }
            }
            PropertyAction {
                property: "ListView.delayRemove"
                value: true
            }
        }
    }
}
