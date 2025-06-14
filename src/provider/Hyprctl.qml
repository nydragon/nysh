pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    enum Type {
        Clients
    }

    signal reply(type: Hyprctl.Type, data: var)

    property var proxyReply: () => {}

    function get(type: int) {
        let msg = "";

        console.log(type === Hyprctl.Type.Clients, type, Hyprctl.Type.Clients);
        switch (type) {
        case Hyprctl.Type.Clients:
            msg = "clients";
            break;
        }

        if (msg === "")
            return;
        socket.connected = true;
        console.log("is", socket.connected);
        root.proxyReply = data => root.reply(type, data);
        socket.write(`j/${msg}`);
        socket.flush();
    }
    onReply: (type, data) => console.log(type, data)

    Socket {
        id: socket
        path: `${Quickshell.env("XDG_RUNTIME_DIR")}/hypr/${Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")}/.socket.sock`
        //connected: true
        onConnectionStateChanged: console.log("Connected to ", connected)

        parser: SplitParser {
            id: parser
            //splitMarker: "\0"
            onRead: data => {
                socket.connected = false;
                console.log(data);
                root.proxyReply(data);
            }
        }
        onError: error => console.error(error)
    }
}
