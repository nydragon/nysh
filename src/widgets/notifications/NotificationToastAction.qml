import Quickshell.Widgets
import Quickshell
import QtQuick
import "../../base"

BMButton {
    id: actionButton

    required property var notifAction
    property bool hasIcons

    IconImage {
        height: 20
        width: 20
        source: actionButton.notifAction?.identifier === "" ? Quickshell.iconPath(actionButton.notifAction?.identifier) : ""
    }

    text: notifAction?.text ?? ""
    onClicked: () => notifAction?.invoke()
}
