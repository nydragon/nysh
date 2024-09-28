pragma Singleton

import Quickshell.Services.Notifications
import Quickshell

Singleton {
    property var d: NotificationServer {
        actionIconsSupported: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: false
        bodySupported: true
        imageSupported: true
    }
}
