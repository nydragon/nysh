import QtQuick

QtObject {
    property bool open: false
    property int mode: Screenshot.Mode.Region

    enum Mode {
        Window,
        Region,
        Monitor
    }

    function toggle() {
        open = !open;
    }

    function setOpen(aOpen: bool) {
        open = aOpen;
    }
}
