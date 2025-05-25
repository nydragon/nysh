import QtQuick
import QtQuick.Layouts
import "../provider"

// TODO: TextInput is stealing interaction from MouseArea, breaking ripple and on click events

MouseArea {
    id: root
    property string text: text.text
    clip: true
    hoverEnabled: true

    BRectangle {
        anchors.fill: parent
        radius: width
        color: Colors.data.colors.dark.surface_container_high
    }

    BRectangle {
        anchors.fill: parent
        radius: width
        color: Colors.data.colors.dark.on_surface
        opacity: 0.08
        visible: parent.containsMouse
    }

    BRectangle {
        id: ripple
        property int diameter: 0
        property alias running: animation.running
        property int mouseX
        property int mouseY

        x: mouseX - diameter / 2
        y: mouseY - diameter / 2
        radius: diameter
        height: diameter
        width: diameter
        color: Colors.data.colors.dark.on_surface
        opacity: 0.1
        visible: false

        function runFrom(x: int, y: int) {
            ripple.mouseX = x;
            ripple.mouseY = y;

            animation.running = false;
            animation.running = true;
        }

        ParallelAnimation {
            id: animation
            NumberAnimation {
                target: ripple
                property: "opacity"
                from: 0.1
                to: 0
                duration: 400
            }
            NumberAnimation {
                target: ripple
                property: "diameter"
                from: 0
                to: root.width
                duration: 400
            }
        }
    }

    //    onClicked: {
    //console.log("clicked");
    //ripple.runFrom(root.mouseX, root.mouseY);
    //}

    RowLayout {
        anchors.fill: parent

        BText {
            text: ""
            fontSizeMode: Text.Fit
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.height
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 720
        }

        TextInput {
            id: text
            color: Colors.data.colors.dark.on_surface
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
        }
    }
}
