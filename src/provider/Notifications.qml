pragma Singleton

import Quickshell.Services.Notifications
import Quickshell
import QtQuick

Singleton {
    id: notif

    property var _: NotificationServer {
        actionIconsSupported: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: false
        bodySupported: true
        imageSupported: true
    }
    Item {

        Component.onCompleted: () => {
            notif._.notification.connect(n => {
                list.push(n);
            });
        }
    }
    property var list: []
}
