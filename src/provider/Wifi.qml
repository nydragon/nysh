pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: networks
    property list<var> list: []
    property list<string> lastBSSIDS: []

    function refresh() {
        getter.running = true;
    }

    signal added(network: var)

    signal removed(network: var)

    Process {
        id: getter
        command: ["nmcli", "-t", "device", "wifi"]
        running: true
        stdout: SplitParser {
            onRead: rawData => {
                rawData = rawData.replace(/\\:/g, ":").split(":");

                const data = {
                    connected: rawData[0] === "*",
                    bssid: rawData.slice(1, 7).join(":").replace(),
                    ssid: rawData[7],
                    mode: rawData[8],
                    channel: rawData[9],
                    rate: rawData[10],
                    signal: rawData[11],
                    bars: rawData[12],
                    security: rawData[13]
                };

                const index = list.findIndex(e => e.bssid === data.bssid);
                if (0 <= index) {
                    Object.assign(networks.list[index], data);
                }

                networks.list.push(data);
                lastBSSIDS.push(data.bssid);
                if (data.connected) {
                    console.log(data.ssid);
                }
                added(data);
            }
        }
        onExited: {
            networks.list.forEach((b, i) => {
                const found = networks.lastBSSIDS.find(e => e.bssid === b);

                if (!found) {
                    networks.list.splice(i, 1);
                    removed(b);
                }
            });
        }
    }
}
