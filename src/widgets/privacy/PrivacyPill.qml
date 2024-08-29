import QtQuick
import QtQuick.Layouts

Rectangle {
    property bool isActive: false
    required property string active
    required property string inactive

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: isActive ? active : inactive
    radius: 10
}
