import QtQuick
import QtQuick.Layouts
import "../../provider"

ListView {
    id: popupcol
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 1000
    spacing: 10
    width: parent.width
    Component.onCompleted: () => {}

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
