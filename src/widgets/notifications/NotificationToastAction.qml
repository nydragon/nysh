import QtQuick.Controls
import Quickshell.Widgets
import QtQuick
import "../../base"

BButton {
    id: actionButton

    required property var notifAction
    required property bool hasIcons

    IconImage {
        visible: parent.hasIcons
        Component.onCompleted: () => {
            if (parent.hasIcons) {
                source = actionButton.notifAction?.identifier ?? "";
            }
        }
    }

    text: notifAction?.text ?? ""
    onClicked: () => notifAction?.invoke()
}
