import Quickshell.Widgets
import Quickshell
import QtQuick
import "../../base"

BMButton {
    id: actionButton

    required property var notifAction
    property bool hasIcons

    text: notifAction?.text ?? ""
    onClicked: () => notifAction?.invoke()
}
