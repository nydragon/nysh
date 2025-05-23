//@ pragma UseQApplication
import Quickshell
import QtQuick

ShellRoot {
    Scope {
        Variants {
            model: Quickshell.screens
            delegate: Nysh {
                required property var modelData
                screen: modelData
            }
        }
    }
}
