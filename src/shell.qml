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

    Component.onCompleted: {
        Quickshell.reloadCompleted.connect(() => loader.active = false);
        Quickshell.reloadFailed.connect(e => {
            loader.active = true;
            loader.message = e;
        });
    }

    LazyLoader {
        id: loader

        property string message: ""

        PanelWindow {
            anchors {
                top: true
                left: true
                right: true
            }

            Text {
                anchors.centerIn: parent
                anchors.fill: parent
                text: loader.message
            }
        }
    }
}
