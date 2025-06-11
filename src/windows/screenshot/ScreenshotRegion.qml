import QtQuick
import "../../provider"

Canvas {
    id: root

    property var workspaceId
    signal save(x: int, y: int, width: int, height: int)
    property color handleColor: Colors.data.colors.dark.primary

    anchors.fill: parent

    onPaint: {
        const ctx = getContext("2d");
        ctx.fillStyle = Qt.rgba(0, 0, 0, 0.2);
        ctx.globalCompositeOperation = "copy";

        ctx.clearRect(0, 0, width, height);
        ctx.beginPath();
        ctx.fillRect(0, 0, width, height);
        ctx.fill();

        ctx.clearRect(rect.x, rect.y, rect.width, rect.height);
    }

    Rectangle {
        id: rect
        width: 400
        height: 400
        color: "transparent"
        border.color: "blue"
        border.width: 3
        onXChanged: root.requestPaint()
        onYChanged: root.requestPaint()
        onWidthChanged: root.requestPaint()
        onHeightChanged: root.requestPaint()

        MouseArea {
            anchors.fill: parent
            onClicked: {
                const p = mapToGlobal(x, y);
                root.save(p.x, p.y, width, height);
            }
            drag {
                target: parent
                minimumX: 0
                minimumY: 0
                maximumX: parent.parent.width - parent.width
                maximumY: parent.parent.height - parent.height
                smoothed: true
            }
        }

        Rectangle {
            height: 20
            width: 20
            radius: width
            color: root.handleColor
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: -(width / 2)

            MouseArea {
                anchors.fill: parent
                drag {
                    target: parent
                }

                onMouseXChanged: {
                    if (drag.active) {
                        rect.width = (rect.width - mouseX) < 30 ? 30 : rect.width - mouseX;
                        rect.x += mouseX;
                    }
                }
                onMouseYChanged: {
                    if (drag.active) {
                        rect.height = (rect.height - mouseY) < 30 ? 30 : rect.height - mouseY;
                        rect.y += mouseY;
                    }
                }
            }
        }

        Rectangle {
            height: 20
            width: 20
            radius: width
            color: root.handleColor
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: -(width / 2)

            MouseArea {
                anchors.fill: parent
                drag {
                    target: parent
                }
                onMouseXChanged: {
                    if (drag.active) {
                        const newWidth = rect.width + mouseX;
                        if (newWidth < 30) {
                            rect.x += mouseX;
                        } else {
                            rect.width = newWidth;
                        }
                    }
                }
                onMouseYChanged: {
                    if (drag.active) {
                        const newHeight = rect.height - mouseY;
                        if (newHeight >= 30) {
                            rect.height = newHeight;
                        }
                        rect.y += mouseY;
                    }
                }
            }
        }

        Rectangle {
            height: 20
            width: 20
            radius: width
            color: root.handleColor
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: -(width / 2)

            MouseArea {
                anchors.fill: parent
                drag.target: parent

                onMouseXChanged: {
                    if (drag.active) {
                        const newWidth = rect.width - mouseX;
                        if (newWidth >= 30)
                            rect.width = newWidth;
                        rect.x += mouseX;
                    }
                }
                onMouseYChanged: {
                    if (drag.active) {
                        const newHeight = rect.height + mouseY;
                        if (newHeight < 30) {
                            rect.y += mouseY;
                        } else {
                            rect.height = newHeight;
                        }
                    }
                }
            }
        }

        Rectangle {
            height: 20
            width: 20
            radius: width
            color: root.handleColor
            anchors.left: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: -(width / 2)

            MouseArea {
                anchors.fill: parent
                drag.target: parent

                onMouseXChanged: {
                    if (drag.active) {
                        const newWidth = rect.width + mouseX;
                        if (newWidth < 30) {
                            rect.x += mouseX;
                        } else {
                            rect.width = newWidth;
                        }
                    }
                }
                onMouseYChanged: {
                    if (drag.active) {
                        const newHeight = rect.height + mouseY;
                        if (newHeight < 30) {
                            rect.y += mouseY;
                        } else {
                            rect.height = newHeight;
                        }
                    }
                }
            }
        }
    }
}
