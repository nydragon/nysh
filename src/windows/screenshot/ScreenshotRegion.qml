pragma ComponentBehavior: Bound

import QtQuick
import "../../provider"

Canvas {
    id: root

    property var workspaceId
    property color handleColor: Colors.data.colors.dark.primary

    signal save(x: int, y: int, width: int, height: int)

    onWidthChanged: {
        rect.x = root.width / 2 - rect.width / 2;
    }

    onHeightChanged: {
        rect.y = root.height / 2 - rect.height / 2;
    }

    component Handle: Rectangle {
        height: 20
        width: 20
        radius: width
        color: root.handleColor
        anchors.margins: -(width / 2) + rect.border.width
    }

    anchors.fill: parent
    onPaint: {
        const ctx = getContext("2d");
        ctx.fillStyle = Qt.rgba(0, 0, 0, 0.3);
        ctx.globalCompositeOperation = "copy";

        ctx.clearRect(0, 0, width, height);
        ctx.beginPath();
        ctx.fillRect(0, 0, width, height);
        ctx.fill();

        ctx.clearRect(rect.x, rect.y, rect.width, rect.height);
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            rect.x = mouseX;
            rect.y = mouseY;

            rect.width = Qt.binding(() => Math.max(mouseX - rect.x, 30));
            rect.height = Qt.binding(() => Math.max(mouseY - rect.y, 30));
        }

        onReleased: {
            rect.width = Math.max(mouseX - rect.x, 30);
            rect.height = Math.max(mouseY - rect.y, 30);
        }
    }

    Rectangle {
        id: rect
        width: 400
        height: 400
        color: "transparent"
        border.color: root.handleColor
        border.width: 2
        onXChanged: root.requestPaint()
        onYChanged: root.requestPaint()
        onWidthChanged: root.requestPaint()
        onHeightChanged: root.requestPaint()

        MouseArea {
            id: d
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

        Handle {
            anchors.left: parent.left
            anchors.top: parent.top

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

        Handle {
            anchors.right: parent.right
            anchors.top: parent.top

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

        Handle {
            anchors.left: parent.left
            anchors.bottom: parent.bottom

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

        Handle {
            anchors.right: parent.right
            anchors.bottom: parent.bottom

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
