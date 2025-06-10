import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../../base"

BRectangle {
    id: root

    required property bool expanded
    required property int animationSpeed
    required property string summary
    required property string body
    required property string image
    required property var actions

    state: root.expanded ? "expanded" : "hidden"
    height: coll.height
    clip: true

    Behavior on height {
        NumberAnimation {
            duration: root.animationSpeed
            property: "height"
        }
    }

    RowLayout {
        id: f
        anchors.fill: parent

        IconImage {
            source: root.image
            Layout.preferredHeight: root.expanded ? 30 : 15
            Layout.preferredWidth: root.expanded ? 30 : 15
            Layout.alignment: Qt.AlignVCenter | Qt.AlignTop

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: root.animationSpeed
                }
            }
            Behavior on Layout.preferredWidth {
                NumberAnimation {
                    duration: root.animationSpeed
                }
            }
        }

        ColumnLayout {
            id: coll

            RowLayout {
                id: header

                Layout.fillWidth: true
                BText {
                    text: root.summary
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                    font.bold: true
                    Layout.preferredHeight: 20
                    Layout.fillWidth: true
                }

                BText {
                    visible: !root.expanded
                    opacity: visible ? 1 : 0
                    text: root.body
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                    Layout.preferredHeight: 20
                    Behavior on opacity {
                        NumberAnimation {
                            duration: root.animationSpeed
                        }
                    }
                }
            }

            BText {
                id: body
                opacity: 0
                text: root.body
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }

            GridLayout {
                id: actions

                Layout.alignment: Qt.AlignHCenter
                columns: root.actions.length < 6 ? root.actions.length : 4
                visible: (root.actions.length && opacity === 1) ?? false

                Repeater {
                    id: rep
                    model: root.actions
                    delegate: NotificationToastAction {
                        required property var modelData
                        notifAction: modelData
                        height: 30
                        width: 100
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "expanded"
            PropertyChanges {
                body.Layout.preferredHeight: body.contentHeight
                body.opacity: 1
                actions.opacity: 1
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                body.Layout.preferredHeight: 0
                body.opacity: 0
                actions.opacity: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "expanded"
            reversible: true
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.InOutQuad
                duration: root.animationSpeed
            }
            NumberAnimation {
                properties: "height"
                easing.type: Easing.InOutQuad
                duration: root.animationSpeed
            }
        }
    ]
}
