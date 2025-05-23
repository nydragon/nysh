import QtQuick
import Quickshell

Item {
    id: root

    required property ShellScreen screen

    property MainBar mainBar: MainBar {
        screen: root.screen
    }
}
