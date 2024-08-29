import "../../base"
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

BRectangle {
    visible: UPower.displayDevice != null
    height: width * 2

    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        color: "transparent"

        Pill {
            id: health
            width: parent.width * 4 / 5
            height: parent.height
            anchors.right: parent.right
            percentage: UPower.displayDevice.healthPercentage
            visible: UPower.displayDevice.healthSupported
        }
        Pill {
            id: battery
            width: parent.width * (!UPower.displayDevice.healthSupported || 3 / 5)
            height: parent.height
            anchors.left: parent.left

            percentage: UPower.displayDevice.percentage
            color: 100 * percentage / 360
        }
    }
}
