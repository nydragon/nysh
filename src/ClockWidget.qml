import QtQuick
import QtQuick.Layouts

ColumnLayout {
    Text {
        text: String(Time.date.getHours()).padStart(2, '0')
    }
    Text {
        text: String(Time.date.getMinutes()).padStart(2, '0')
    }
}
