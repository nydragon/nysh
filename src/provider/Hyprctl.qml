pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root

    enum Type {
        Clients,
        Unknown
    }

    signal reply(type: int, data: var)

    function get(type: int) {
        if (socket.connected) {
            console.log("d");
            return;
        }

        socket.command = type;
        socket.connected = true;
    }

    onReply: (type, data) => console.log(type, data)

    Socket {
        id: socket

        property int command: Hyprctl.Type.Unknown

        path: Hyprland.requestSocketPath
        onConnectionStateChanged: {
            if (connected) {
                console.log("Sending message");
                let msg = "";
                switch (this.command) {
                case Hyprctl.Type.Clients:
                    msg = "clients";
                    break;
                }
                if (msg === "") {
                    this.connected = false;
                    return;
                }
                this.write(`j/${msg}`);
                this.flush();
            } else {
                const data = JSON.parse(parser.rawData);
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
        onError: error => console.error("Socket error: ", error)
    }
}
