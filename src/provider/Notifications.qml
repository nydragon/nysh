pragma Singleton

import Quickshell.Services.Notifications
import Quickshell
import QtQuick
import "../utils/timer.mjs" as Timer

Singleton {
    id: notif

    property var _: NotificationServer {
        id: server
        actionIconsSupported: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: false
        bodySupported: true
        imageSupported: true

        onNotification: n => {
            n.tracked = true;

            notif.incomingAdded(n);

            Timer.after(1000, notif, () => {
                notif.incomingRemoved(n.id);
            });
        }
    }

    property alias list: server.trackedNotifications

    function clearAll() {
        const len = server.trackedNotifications.values.length;
        for (let i = 0; i < len; i++) {
            list.values[0].dismiss();
        }
    }

    signal incomingRemoved(id: int)
    signal incomingAdded(id: Notification)
}
