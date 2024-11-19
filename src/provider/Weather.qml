pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: weather

    property var lastFetch: {}
    property string dataRaw: ""

    property int feltTemp: lastFetch?.current_condition[0]?.FeelsLikeC ?? 0
    property int actualTemp: lastFetch?.current_condition[0]?.temp_C ?? 0
    property string description: lastFetch?.current_condition[0]?.weatherDesc[0].value ?? ""
    property string icon: getIcon(lastFetch?.current_condition[0]?.weatherCode)

    function getIcon(weatherCode: string): string {
        switch (weatherCode) {
        case "116":
            return "weather-few-clouds";
        default:
            return "weather-none-available";
        }
    }

    Process {
        id: get
        command: ["curl", "wttr.in?format=j1"]
        running: true
        stdout: SplitParser {
            onRead: e => {
                weather.dataRaw += e;
            }
        }
        onRunningChanged: {
            if (running) {
                weather.dataRaw = "";
            }
            if (!running) {
                weather.lastFetch = JSON.parse(weather.dataRaw);
            }
        }
    }

    Timer {
        interval: 1000 * 60 * 60
        repeat: true
        onTriggered: get.running = true
    }
}
