import QtQuick
import QtQuick.Layouts
import "../provider"

MouseArea {
    id: root
    Layout.preferredHeight: 20
    Layout.preferredWidth: 20
    property bool active: false
    onClicked: active = active || !active

    Rectangle {
        anchors.fill: parent
        radius: parent.width / 2
        border.width: 2
        border.color: parent.active ? Colors.data.colors.dark.primary : Colors.data.colors.dark.on_surface_variant
        color: "transparent"

        Rectangle {
            width: 10
            height: 10
            anchors.centerIn: parent
            radius: 20 / 2
            visible: root.active
            Layout.alignment: Qt.AlignCenter
            color: Colors.data.colors.dark.primary

            Behavior on color {
                ColorAnimation {
                    duration: Config.data.colourFadeSpeed
                }
            }
        }
    }
}
