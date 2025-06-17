//@ pragma UseQApplication
import Quickshell
import QtQuick
import "windows/notificationtoast"
import "windows/dashboard"
import "windows/screenshot"
import "windows/osd"

ShellRoot {
    MainBar {}

    NotificationToasts {}

    LazyLoader {
        loading: true
        Dashboard {}
    }

    LazyLoader {
        loading: true
        Screenshot {}
    }

    LazyLoader {
        loading: true
        OsdAudio {}
    }
}
