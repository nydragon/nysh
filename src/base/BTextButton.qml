import QtQuick

BButton {
    required property string text
    BText {
        text: parent.text
        fontSizeMode: Text.Fit
        height: parent.height
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 720
    }
}
