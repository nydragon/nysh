import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    required property var source
    color: "transparent"

    Image {
        id: background
        anchors.fill: parent
        source: root.source
        Layout.alignment: Qt.AlignHCenter
        visible: false
    }

    MultiEffect {
        id: image
        autoPaddingEnabled: false
        source: background
        anchors.fill: background
        blurEnabled: true
        blurMax: 64
        blurMultiplier: 2
        blur: 1
        brightness: -0.15
        contrast: -0.35
        maskEnabled: true
        maskSource: mask
        anchors.margins: root.border.width - 1
    }

    Rectangle {
        id: mask
        width: image.width
        height: image.height
        layer.enabled: true
        visible: false

        radius: root.radius
        color: "black"
    }
}
