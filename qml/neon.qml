import QtQuick
import QtQuick.Window
import Gai

Window {
    id: root
    width: 400
    height: 500
    visible: true
    title: "Neon DatePicker"
    color: "#0a0a1a"

    property font appFont: Qt.font({ family: "Arial", pointSize: 14 })

    DatePicker {
        anchors.centerIn: parent
        width: parent.width * 0.8
        height: parent.height * 0.8
        font: root.appFont

        selectedDate: new Date(2026, 5, 15)
        dateRange: ({ begin: new Date(2020, 0, 1), end: new Date(2030, 11, 31) })

        delegate: Text {
            text: modelData
            font: root.appFont
            color: "#00ffcc"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: "#0a0a1a"
            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: parent.height * 0.35
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#e00a0a1a" }
                    GradientStop { position: 1.0; color: "#000a0a1a" }
                }
                z: 1
            }
            Rectangle {
                anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
                height: parent.height * 0.35
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#000a0a1a" }
                    GradientStop { position: 1.0; color: "#e00a0a1a" }
                }
                z: 1
            }
        }
        highlight: Rectangle { color: "#1100ffcc"; border.color: "#00ffcc"; border.width: 1; radius: 6 }
    }
}
