import Quickshell.Widgets
import QtQuick
import "../../base"

BButton {
    id: actionButton

    required property var notifAction
    property bool hasIcons

    IconImage {
        source: actionButton.notifAction?.identifier ?? ""
    }

    text: notifAction?.text ?? ""
    onClicked: () => notifAction?.invoke()
}
