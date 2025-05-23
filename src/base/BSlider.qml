import QtQuick.Controls
import QtQuick
import "../provider"

Slider {
    id: sli
    property double innerRadius: height / 10
    property double outerRadius: height

    handle: Rectangle {
        color: Colors.data.colors.dark.primary
        height: parent.implicitHeight
        radius: 50
        width: 5
        x: sli.leftPadding + sli.visualPosition * (sli.availableWidth - implicitWidth)
        y: sli.availableHeight / 2
    }

    background: Item {}
    padding: 10

    //    anchors.leftMargin: 10
    //anchors.rightMargin: 10
    hoverEnabled: true

    BRectangle {
        opacity: sli.hovered ? 0.2 : 0.1
        color: "#000000"
        anchors.fill: parent
        radius: height

        Behavior on opacity {
            NumberAnimation {
                duration: 100
            }
        }
    }

    Rectangle {
        color: Colors.data.colors.dark.primary
        topLeftRadius: sli.outerRadius
        bottomLeftRadius: sli.outerRadius
        topRightRadius: sli.innerRadius
        bottomRightRadius: sli.innerRadius

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height / 3
        anchors.right: sli.handle.left
        anchors.rightMargin: 5
        anchors.leftMargin: 10

        Behavior on color {
            ColorAnimation {
                duration: 1000
            }
        }
    }

    Rectangle {
        color: Colors.data.colors.dark.secondary_container
        topLeftRadius: sli.innerRadius
        bottomLeftRadius: sli.innerRadius
        topRightRadius: sli.outerRadius
        bottomRightRadius: sli.outerRadius
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height / 3
        anchors.left: sli.handle.right
        anchors.leftMargin: 5
        anchors.rightMargin: 10
        Behavior on color {
            ColorAnimation {
                duration: 1000
            }
        }
        clip: true

        Rectangle {
            color: Colors.data.colors.dark.on_secondary_container
            height: parent.height / 3
            width: parent.height / 3
            anchors.verticalCenter: parent.verticalCenter
            radius: height
            anchors.right: parent.right
            anchors.margins: 3
            Behavior on color {
                ColorAnimation {
                    duration: 1000
                }
            }
        }
    }
}
