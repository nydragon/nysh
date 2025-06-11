pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "windows/dashboard"
import "windows/screenshot"

Item {
    id: root

    required property ShellScreen screen

    property MainBar mainBar: MainBar {
        screen: root.screen
    }

    LazyLoader {
        loading: true

        Dashboard {
            screen: root.screen
        }
    }

    Screenshot {
        screen: root.screen
    }
}
