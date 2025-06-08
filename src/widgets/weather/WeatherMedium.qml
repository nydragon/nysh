import QtQuick.Layouts
import QtQuick
import Quickshell.Widgets
import Quickshell
import QtQml

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

        GridLayout {
            Layout.margins: 10
            Repeater {

                model: Weather.lastFetch?.weather

                delegate: Rectangle {
                    id: forecastRect
                    required property var modelData
                    property string mintempC: modelData.mintempC
                    property string maxtempC: modelData.maxtempC
                    property string date: modelData.date

                    color: "#D7B4F3"
                    radius: 5

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout {
                        anchors.fill: parent

                        Text {
                            text: {
                                const day = (new Date(forecastRect.date)).getDay();
                                const weekday = Qt.locale().dayName(day, Locale.LongFormat);
                                return weekday;
                            }
                            Layout.alignment: Qt.AlignCenter
                        }
                        Text {
                            text: `${forecastRect.mintempC}°C - ${forecastRect.maxtempC}°C`
                            Layout.alignment: Qt.AlignCenter
                        }
                    }
                }
            }
        }
    }
}
