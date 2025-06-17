pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root

    property list<var> clients: []

    enum Type {
        Clients,
        Unknown
    }

    signal reply(type: int, data: var)

    function get(type: int) {
        if (socket.connected) {
            return;
        }

        socket.command = type;
        socket.connected = true;
    }

    Socket {
        id: socket

        property int command: Hyprctl.Type.Unknown

        path: Hyprland.requestSocketPath
        onConnectionStateChanged: {
            if (connected) {
                let msg = "";
                switch (this.command) {
                case Hyprctl.Type.Clients:
                    msg = "clients";
                    break;
                case Hyprctl.Type.Unknown:
                default:
                    return;
                }
                if (msg === "") {
                    this.connected = false;
                    return;
                }
                this.parser.rawData = "";
                this.write(`j/${msg}`);
                this.flush();
            } else {
                const data = JSON.parse(parser.rawData);

                if (this.command === Hyprctl.Type.Clients) {
                    root.clients = data;
                }

                root.reply(this.command, data);
            }
        }
        parser: SplitParser {
            id: parser
            property string rawData: ""
            splitMarker: ""
            onRead: data => {
                rawData += data;
            }
        }
    }
}
