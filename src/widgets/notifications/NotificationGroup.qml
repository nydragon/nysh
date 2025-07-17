pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell

import "../../provider"
import "../../base"

BRectangle {
    id: root

    required property var modelData
    property string appName: modelData.appName
    property string appIcon: modelData.appIcon
    property list<var> notifications: modelData.notifications
    property int index: modelData.index
    property int total: modelData.total
    property bool expanded: false
    readonly property int animationSpeed: 100
    readonly property int outerRadius: 20
    readonly property int innerRadius: 5

    color: Colors.colors.surface_container_high
    height: rep.childrenRect.height + col.anchors.margins * 2 + fd.childrenRect.height + 15
    radius: 20
    topLeftRadius: root.index === 0 ? outerRadius : innerRadius
    topRightRadius: root.index === 0 ? outerRadius : innerRadius
    bottomLeftRadius: root.index === root.total - 1 ? outerRadius : innerRadius
    bottomRightRadius: root.index === root.total - 1 ? outerRadius : innerRadius

    MouseArea {
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded

        drag.target: parent
        drag.axis: Drag.XAxis

        onReleased: event => {
            root.x = 0;
        }
    }

    Behavior on x {
        NumberAnimation {
            property: "x"
        }
    }

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 10
        RowLayout {
            id: fd
            IconImage {
                source: root.appIcon ? Quickshell.iconPath(root.appIcon) : ""
                Layout.preferredHeight: 30
                Layout.preferredWidth: 30

                Layout.alignment: Qt.AlignVCenter | Qt.AlignTop
            }

            BText {
                text: root.appName
            }
        }
        ColumnLayout {
            id: notifs
            Layout.alignment: Qt.AlignVCenter

            ListView {
                id: rep
                clip: true
                model: ScriptModel {
                    values: root.expanded ? root.notifications : [...root.notifications].slice(0, 3)
                }
                spacing: root.expanded ? 15 : 5
                focusPolicy: Qt.NoFocus
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: root.expanded ? 0 : 30

                Behavior on Layout.leftMargin {
                    NumberAnimation {
                        duration: root.animationSpeed
                    }
                }

                delegate: Notification {
                    required property var modelData

                    width: rep.width
                    animationSpeed: root.animationSpeed
                    expanded: root.expanded
                    summary: modelData.summary
                    body: modelData.body
                    image: modelData.image
                    actions: modelData.actions
                }
            }
        }
    }
}
