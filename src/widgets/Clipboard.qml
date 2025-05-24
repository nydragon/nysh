pragma ComponentBehavior: Bound
import QtQuick
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
                    id,
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
            onClicked: root.entries = []
        }
    }

    ListView {
        id: listView
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        highlightFollowsCurrentItem: true
        model: root.entries.filter(e => {
            if (root.showImages)
                return e.isImage;
            else
                return e.content.includes(root.text);
        })
        spacing: 5

        delegate: MouseArea {
            id: delegate
            required property int id
            required property string content
            required property bool isImage
            property bool expanded: false

            hoverEnabled: true
            implicitWidth: listView.width
            implicitHeight: expanded ? (img.height > 100 ? img.height : 100) : 100

            Behavior on height {
                NumberAnimation {
                    duration: 30
                }
            }

            BCard {
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
                        text: delegate.content
                        wrapMode: Text.Wrap
                    }

                    Image {
                        id: img
                        visible: delegate.isImage
                        source: delegate.isImage ? `file:///tmp/${delegate.id}` : ""
                        width: parent.width
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                        height: width * (sourceSize.height / sourceSize.width)
                    }
                }
            }
        }
    }
}
