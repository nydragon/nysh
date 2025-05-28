pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell

import "../../provider"
import "../../base"

MouseArea {
    id: root
    required property var modelData
    property string appName: modelData.appName
    property string appIcon: modelData.appIcon
    property list<var> notifications: modelData.notifications
    property int index: modelData.index
    property int total: modelData.total
    property bool expanded: false
    readonly property int animationSpeed: 100
    property string state: expanded ? "EXPANDED" : "COLLAPSED"

    onClicked: expanded = !expanded
    height: rep.childrenRect.height + col.anchors.margins * 2 + fd.childrenRect.height + 15

    BRectangle {
        color: Colors.data.colors.dark.surface_container_high

        radius: 20
        topLeftRadius: root.index === 0 ? 20 : 0
        topRightRadius: root.index === 0 ? 20 : 0
        bottomLeftRadius: root.index === root.total - 1 ? 20 : 0
        bottomRightRadius: root.index === root.total - 1 ? 20 : 0
        anchors.fill: parent

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
            RowLayout {
                ColumnLayout {
                    id: notifs
                    Layout.alignment: Qt.AlignVCenter

                    ListView {
                        id: rep
                        clip: true
                        model: ScriptModel {
                            values: root.expanded ? root.notifications : [...root.notifications].slice(0, 3)
                        }
                        spacing: 15
                        focusPolicy: Qt.NoFocus
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: root.expanded ? 0 : 30

                        Behavior on Layout.leftMargin {
                            NumberAnimation {
                                duration: root.animationSpeed
                            }
                        }

                        delegate: BRectangle {
                            id: delegate
                            required property var modelData
                            property string summary: modelData.summary
                            property string body: modelData.body
                            property string image: modelData.image

                            height: (root.expanded ? body.contentHeight : 0) + header.contentHeight

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
                                    source: delegate.image
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
                                    Layout.alignment: Qt.AlignTop
                                    RowLayout {
                                        BText {
                                            id: header
                                            text: delegate.summary
                                            elide: root.expanded ? Text.ElideNone : Text.ElideRight
                                            wrapMode: Text.Wrap
                                            Layout.preferredHeight: 10
                                            font.bold: true
                                        }

                                        BText {
                                            visible: !root.expanded
                                            opacity: visible ? 1 : 0
                                            text: delegate.body
                                            elide: Text.ElideRight
                                            wrapMode: Text.Wrap
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 10
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
                                        text: delegate.body
                                        state: root.expanded ? "expanded" : "hidden"
                                        //elide: root.expanded ? Text.ElideNone : Text.ElideRight
                                        wrapMode: Text.Wrap
                                        Layout.fillWidth: true
                                        states: [
                                            State {
                                                name: "expanded"
                                                PropertyChanges {
                                                    body.Layout.preferredHeight: body.contentHeight
                                                    body.opacity: 1
                                                }
                                            },
                                            State {
                                                name: "hidden"
                                                PropertyChanges {
                                                    body.Layout.preferredHeight: 0
                                                    body.opacity: 0
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
                                            }
                                        ]
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
