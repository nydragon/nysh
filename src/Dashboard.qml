import QtQuick
import QtQuick.Layouts
import QtQml
import "base"
import "widgets/mpris"
import "widgets/notifications"
import "provider"
import "widgets/mpris"
import "widgets/notifications"
import "widgets"
import "widgets/audio"
import "base"
import "provider"

BRectangle {
    id: root

    property bool shown: false

    color: Colors.data.colors.dark.surface
    border.color: Colors.data.colors.dark.on_surface_variant
    radius: 20
    visible: opacity != 0
    opacity: shown ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: 100
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        MprisSmall {
            Layout.preferredHeight: 150
            Layout.fillWidth: true
        }

        BSection {
            id: audioSection
            open: NyshState.audioOpen
            Layout.fillWidth: true
            text: "Audio"
            Sinks {
                id: sink
                Layout.fillWidth: true
                visible: audioSection.open
            }
        }

        BSection {
            id: clipboardSection
            Layout.fillWidth: true
            text: "Clipboard"

            Clipboard {
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                visible: parent.open
            }
        }

        NotificationInbox {
            Layout.preferredHeight: 1000
            Layout.fillWidth: true
        }
    }
}
