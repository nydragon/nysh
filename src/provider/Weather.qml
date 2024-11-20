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
    property var astronomy: lastFetch?.weather[0].astronomy[0] ?? {}

    function getIcon(weatherCode: string): string {
        let day = true;

        if (astronomy.sunset && astronomy.sunrise) {
            const now = new Date();
            let [sunsetH, sunsetM] = astronomy.sunset.match(/\d{2}/g).map(n => Number.parseInt(n));
            if (astronomy.sunset.endsWith("PM")) {
                sunsetH += 12;
            }
            let [sunriseH, sunriseM] = astronomy.sunrise.match(/\d{2}/g).map(n => Number.parseInt(n));
            if (astronomy.sunrise.endsWith("PM")) {
                sunriseH += 12;
            }
            const nowH = now.getHours();
            const nowM = now.getMinutes();
            const afterSunrise = (sunriseH < nowH || (sunriseH === nowH && sunriseM <= nowM));
            const beforeSunset = (nowH < sunsetH || (nowH === sunsetH && nowM <= sunsetM));
            day = afterSunrise && beforeSunset;
        }

        switch (weatherCode) {
        case "113":
            return day ? "weather-clear" : "weather-clear-night";
        case "116":
            return day ? "weather-few-clouds" : "weather-few-clouds-night";
        case "122":
            return "weather-overcast";
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
