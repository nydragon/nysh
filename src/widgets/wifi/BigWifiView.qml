import QtQuick
import QtQuick.Layouts
import "../../base"
import "../../provider"

ColumnLayout {
    id: wifi

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.margins: 15

    property ListModel networks: ListModel {
        id: list
        Component.onCompleted: {
            Wifi.list.forEach(e => list.append(e));
            Wifi.added.connect(e => list?.append(e));
            Wifi.removed.connect(e => {
                for (let i = 0; i < list?.count; i++) {
                    if (list.get(i).bssid === e.bssid) {
                        list.remove(i);
                        break;
                    }
                }
            });
        }
    }

    signal navigationReturn

    ListView {
        id: re
        visible: wifi.networks.count > 0
        model: wifi.networks
        Layout.fillHeight: true
        Layout.fillWidth: true
        height: 500
        spacing: 10
        delegate: BRectangle {
            id: con
            required property string ssid
            required property string bssid
            required property bool connected
            required property string rate
            required property string bars
            required property int index

            height: 40
            width: ListView.view.width

            RowLayout {
                anchors.fill: parent
                anchors.margins: 7.5

                Text {
                    text: con.ssid?.length ? con.ssid : con.bssid
                    Layout.preferredWidth: parent.width * 0.2
                }

                Text {
                    text: con.rate
                    Layout.preferredWidth: parent.width * 0.1
                }
                Text {
                    text: con.bars
                    width: 30
                    Layout.preferredWidth: 30
                    Layout.maximumWidth: 30
                }

                Rectangle {
                    width: height
                    height: parent.height - (con.Layout.margins * 2)
                    Layout.preferredWidth: 30
                    Layout.maximumWidth: 30

                    color: {
                        const v = con.bssid.split(":").map(n => Number.parseInt(n, 16));
                        const value = v.reduce((acc, v) => {
                            acc[acc.length - 1]?.length < 2 ? acc[acc.length - 1].push(v) : acc.push([v]);
                            return acc;
                        }, [])//
                        .map(([a, b]) => Math.floor(((a + b) / 2)).toString(16)) //
                        .join("");
                        return `#${value}`;
                    }
                    Layout.alignment: Qt.AlignRight
                }

                BButton {
                    text: con.connected ? "disconnect" : "connect"
                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: implicitWidth
                    Layout.maximumWidth: parent.width * 0.2
                    Layout.minimumWidth: parent.width * 0.2
                    Layout.fillHeight: true
                    height: 30
                    width: 30
                }
            }
        }
    }

    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
    RowLayout {
        Layout.fillWidth: true
        BButton {
            text: "return"
            onClicked: wifi.navigationReturn()
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            width: 30
            height: 30
        }

        BButton {
            text: "refresh"
            onClicked: Wifi.refresh()
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            Layout.fillWidth: true
            width: 30
            height: 30
        }
    }
}
