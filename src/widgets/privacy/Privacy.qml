import "root:base"
import QtQuick.Layouts

BRectangle {
    height: width

    RowLayout {
        anchors.fill: parent
        spacing: 1
        anchors.margins: 3

        PrivacyPill {
            active: "#FF7F50"
            inactive: "#b1a4a0"
        }
        PrivacyPill {
            active: "#E0B0fF"
            inactive: "#dad5dd"
        }
        PrivacyPill {
            active: "#57ffcd"
            inactive: "#a2b3ae"
        }
    }
}
