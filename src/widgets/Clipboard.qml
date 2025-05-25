pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import "../base"

ColumnLayout {
    id: root
    property list<var> entries: []
    property alias text: search.text
    property alias showImages: imageFilter.active
    Layout.preferredHeight: 900
    Layout.preferredWidth: 300
    onVisibleChanged: {
        if (visible)
            fetcher.running = true;
    }
    Process {
        id: fetcher
        property list<var> tmpEntries: []
        command: ["cliphist", "list"]
        stdout: SplitParser {
            onRead: data => {
                const separator = "	";
                const [id, ...splitContent] = data.split(separator);
                const content = splitContent.join(separator);
                let isImage = false;

                if (content.startsWith("[[ binary")) {
                    getter.write(`${id}\n`);
                    isImage = true;
                }

                fetcher.tmpEntries.push({
                    id: Number(id),
                    content,
                    isImage
                });
            }
        }
        onExited: root.entries = tmpEntries
        onStarted: tmpEntries = []
    }

    Process {
        id: getter
        running: true
        command: ["get-image.sh"]
        stdinEnabled: true
    }

    Process {
        id: deleter
        command: ["cliphist", "wipe"]
    }

    Process {
        id: copyToClip
        running: true
        command: ["copy-to-clip.sh"]
        stdinEnabled: true
        function copy(id: int) {
            copyToClip.write(`${id}\n`);
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: 30

        BSearch {
            id: search
            Layout.fillWidth: true
            Layout.preferredHeight: 30
        }

        BMButton {
            id: imageFilter
            Layout.preferredHeight: 30
            Layout.preferredWidth: 30
            text: ""
            toggleable: true
        }

        BMButton {
            Layout.preferredHeight: 30
            Layout.preferredWidth: 30
            text: ""
            onClicked: {
                root.entries = [];
                deleter.running = true;
            }
        }
    }

    ListView {
        id: listView

        property int animationSpeed: 150

        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        highlightFollowsCurrentItem: true
        spacing: 5

        model: ScriptModel {
            objectProp: "id"
            values: [...root.entries.filter(e => {
                    if (root.showImages)
                        return e.isImage;
                    else
                        return e.content.includes(root.text);
                })]
        }

        populate: Transition {
            NumberAnimation {
                properties: "x,y"
                from: 0
                duration: listView.animationSpeed
            }
        }

        remove: Transition {
            NumberAnimation {
                properties: "x,y"
                to: 0
                duration: listView.animationSpeed
            }
        }

        removeDisplaced: Transition {
            NumberAnimation {
                properties: "x,y"
                duration: listView.animationSpeed
            }
        }

        delegate: MouseArea {
            id: delegate
            required property var modelData
            property bool expanded: card.toggled

            hoverEnabled: true
            implicitWidth: listView.width
            implicitHeight: {
                if (expanded && modelData.isImage) {
                    return img.height > 100 ? img.height : 100;
                } else if (expanded) {
                    return 100;
                } else {
                    return 100;
                }
            }

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 100
                }
            }

            BCard {
                id: card
                anchors.fill: parent
                clip: true

                BRectangle {
                    anchors.fill: parent
                    anchors.centerIn: parent
                    anchors.margins: 10
                    clip: true

                    BText {
                        id: text
                        width: parent.width
                        text: delegate.modelData.content
                        wrapMode: Text.Wrap
                        textFormat: Text.PlainText
                    }

                    Image {
                        id: img
                        visible: delegate.modelData.isImage
                        source: delegate.modelData.isImage ? `file:///tmp/${delegate.modelData.id}` : ""
                        width: parent.width
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                        height: width * (sourceSize.height / sourceSize.width)
                    }
                }

                BMButton {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 5
                    width: 30
                    height: 30
                    text: ""
                    onClicked: copyToClip.copy(delegate.modelData.id)
                }
            }
        }
    }
}
