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

        onNotification: n => {
            n.tracked = true;
            incoming.push(n);
        }
    }

    property list<Notification> backlog: notif._.trackedNotifications
    property list<Notification> incoming: []
}
