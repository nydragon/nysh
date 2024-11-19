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
}
