pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

import "../../provider"
import "../../base"

ColumnLayout {
    RowLayout {
        Layout.alignment: Qt.AlignRight
        BToggle {
            id: sw
            onClicked: () => {
                NyshState.dndOn = active;
            }
            active: NyshState.dndOn
        }

        BMButton {
            Layout.preferredWidth: 30
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignRight
            text: ""
            onClicked: () => {
                Notifications.clearAll();
            }
        }
    }

    ListView {
        id: popupcol
        Layout.fillHeight: true
        Layout.fillWidth: true
        clip: true
        spacing: 2

        model: ScriptModel {
            values: {
                const sorted = {};
                const icons = {};

                Notifications.list.values.forEach(notif => {
                    if (!sorted[notif.appName]) {
                        sorted[notif.appName] = [];
                    }
                    sorted[notif.appName].push(notif);
                    icons[notif.appName] = icons[notif.appName] ?? notif.appIcon;
                });
                const entries = Object.entries(sorted);
                return entries.map(([appName, notifications], index) => {
                    return {
                        appName,
                        appIcon: icons[appName],
                        notifications,
                        index,
                        total: entries.length
                    };
                });
            }
        }
        delegate: NotificationGroup {
            width: popupcol.width
        }
        //        addDisplaced: Transition {
        //NumberAnimation {
        //properties: "x,y"
        //duration: 100
        //}
        //}
        //        remove: Transition {
        //PropertyAction {
        //property: "ListView.delayRemove"
        //value: true
        //}
        //ParallelAnimation {
        //NumberAnimation {
        //property: "opacity"
        //to: 0
        //duration: 200
        //}
        //}
        //PropertyAction {
        //property: "ListView.delayRemove"
        //value: true
        //}
        //}
    }
}
