import QtQuick

QtObject {
    property bool open: false

    function toggle() {
        open = !open;
    }

    function set(aOpen: bool) {
        open = aOpen;
    }
}
