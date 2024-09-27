import QtQuick
import QtQuick.Effects

Rectangle {
    id: roundedImage
    required property var source
    height: 300
    width: 300
    color: "transparent"

    Image {
        id: image
        source: roundedImage.source ?? ""
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.margins: roundedImage.border.width
        visible: false
    }

    MultiEffect {
        source: image
        anchors.fill: image
        maskEnabled: true
        maskSource: mask
    }

    Item {
        id: mask
        width: image.width
        height: image.height
        layer.enabled: true
        visible: false

        Rectangle {
            width: image.width
            height: image.height
            radius: roundedImage.radius
            color: "black"
        }
    }
}
