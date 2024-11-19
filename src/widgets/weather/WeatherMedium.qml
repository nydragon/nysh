import QtQuick.Layouts
import QtQuick
import Quickshell.Widgets
import Quickshell

import "../../provider"
import "../../base"

BRectangle {
    id: weather
    property var area: Weather.lastFetch?.nearest_area[0]
    property var condition: Weather.lastFetch?.current_condition[0]

    RowLayout {
        anchors.leftMargin: 10
        anchors.fill: parent

        IconImage {
            source: Quickshell.iconPath(Weather.icon)
            Layout.preferredWidth: parent.height - 20
            Layout.preferredHeight: parent.height - 20
        }

        Column {
            Layout.alignment: Qt.AlignLeft
            Text {
                text: `${weather.area?.areaName[0]?.value}, ${weather.area?.country[0]?.value}`
            }

            Text {
                text: `${Weather.actualTemp}${Weather.actualTemp != Weather.feltTemp ? `(${Weather.feltTemp})` : ""}°C`
            }

            Text {
                text: Weather.description
            }
        }

        Item {
            Layout.fillWidth: true
            height: 1
        }
    }
}
