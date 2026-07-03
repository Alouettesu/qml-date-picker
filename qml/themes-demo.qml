import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Shapes
import Gai

Window {
    id: root
    width: 1200
    height: 560
    visible: true
    title: "DatePicker — All themes"
    color: "#2a2a2a"

    property font appFont: Qt.font({ family: "Arial", pointSize: 14 })
    property date sharedSelectedDate: new Date(2026, 5, 15)
    property var  sharedDateRange:    ({ begin: new Date(2020, 0, 1), end: new Date(2030, 11, 31) })

    // ── Default ──────────────────────────────────────────────────────────────
    Component {
        id: defaultHighlight
        Rectangle { color: "transparent"; border.color: "#409eff"; border.width: 1; radius: 6 }
    }
    Component { id: defaultBackground; Item {} }
    Component {
        id: defaultDelegate
        Text {
            anchors.centerIn: parent
            text: modelData; font: root.appFont; color: "#222"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Minimal ──────────────────────────────────────────────────────────────
    Component {
        id: minimalHighlight
        Item {
            Rectangle {
                anchors { left: parent.left; right: parent.right; top: parent.top }
                anchors.leftMargin: 8; anchors.rightMargin: 8
                height: 1; color: "#bbb"
            }
            Rectangle {
                anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
                anchors.leftMargin: 8; anchors.rightMargin: 8
                height: 1; color: "#bbb"
            }
        }
    }
    Component { id: minimalBackground; Item {} }
    Component {
        id: minimalDelegate
        Text {
            anchors.centerIn: parent
            text: modelData; font: root.appFont; color: "#555"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Dark ─────────────────────────────────────────────────────────────────
    Component {
        id: darkHighlight
        Rectangle { color: "#18ffffff"; border.color: "#44ffffff"; border.width: 1; radius: 6 }
    }
    Component {
        id: darkBackground
        Rectangle {
            color: "#1e1e1e"
            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#e01e1e1e" }
                    GradientStop { position: 1.0; color: "#001e1e1e" }
                }
                z: 1
            }
            Rectangle {
                anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#001e1e1e" }
                    GradientStop { position: 1.0; color: "#e01e1e1e" }
                }
                z: 1
            }
        }
    }
    Component {
        id: darkDelegate
        Text {
            anchors.centerIn: parent
            text: modelData; font: root.appFont; color: "#eee"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Neon ─────────────────────────────────────────────────────────────────
    Component {
        id: neonHighlight
        Rectangle { color: "#1100ffcc"; border.color: "#00ffcc"; border.width: 1; radius: 6 }
    }
    Component {
        id: neonBackground
        Rectangle {
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
    }
    Component {
        id: neonDelegate
        Text {
            anchors.centerIn: parent
            text: modelData; font: root.appFont; color: "#00ffcc"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Retro ────────────────────────────────────────────────────────────────
    Component {
        id: retroHighlight
        Rectangle { color: "#a0ffe0b2"; border.color: "#bf6c00"; border.width: 2; radius: 3 }
    }
    Component {
        id: retroBackground
        Rectangle {
            color: "#fdf5e6"; radius: 4; border.color: "#d4a96a"; border.width: 1
            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#fffdf5e6" }
                    GradientStop { position: 1.0; color: "#00fdf5e6" }
                }
                z: 1
            }
            Rectangle {
                anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00fdf5e6" }
                    GradientStop { position: 1.0; color: "#fffdf5e6" }
                }
                z: 1
            }
        }
    }
    Component {
        id: retroDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font.family: "Courier"; font.pointSize: root.appFont.pointSize
            color: "#3d2b00"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Neon2 ────────────────────────────────────────────────────────────────
    Component {
        id: neon2HighlightYear
        Shape {
            id: shapeYear
            ShapePath {
                strokeColor: "#00ffcc"; strokeWidth: 1; fillColor: "#2200ffcc"
                startX: shapeYear.width; startY: shapeYear.height
                PathLine { x: 6;              y: shapeYear.height }
                PathArc  { x: 0;              y: shapeYear.height - 6; radiusX: 6; radiusY: 6 }
                PathLine { x: 0;              y: 6 }
                PathArc  { x: 6;              y: 0; radiusX: 6; radiusY: 6 }
                PathLine { x: shapeYear.width; y: 0 }
            }
        }
    }
    Component {
        id: neon2HighlightMonth
        Shape {
            id: shapeMonth
            ShapePath {
                strokeColor: "transparent"; strokeWidth: 0; fillColor: "#2200ffcc"
                startX: 0; startY: 0
                PathLine { x: shapeMonth.width; y: 0 }
                PathLine { x: shapeMonth.width; y: shapeMonth.height }
                PathLine { x: 0;               y: shapeMonth.height }
                PathLine { x: 0;               y: 0 }
            }
            ShapePath {
                strokeColor: "#00ffcc"; strokeWidth: 1; fillColor: "transparent"
                startX: 0; startY: 0
                PathLine { x: shapeMonth.width; y: 0 }
            }
            ShapePath {
                strokeColor: "#00ffcc"; strokeWidth: 1; fillColor: "transparent"
                startX: 0; startY: shapeMonth.height
                PathLine { x: shapeMonth.width; y: shapeMonth.height }
            }
        }
    }
    Component {
        id: neon2HighlightDay
        Shape {
            id: shapeDay
            ShapePath {
                strokeColor: "#00ffcc"; strokeWidth: 1; fillColor: "#2200ffcc"
                startX: 0; startY: 0
                PathLine { x: shapeDay.width - 6; y: 0 }
                PathArc  { x: shapeDay.width;     y: 6;                 radiusX: 6; radiusY: 6 }
                PathLine { x: shapeDay.width;     y: shapeDay.height - 6 }
                PathArc  { x: shapeDay.width - 6; y: shapeDay.height;   radiusX: 6; radiusY: 6 }
                PathLine { x: 0;                  y: shapeDay.height }
            }
        }
    }
    Component {
        id: neon2Delegate
        Text {
            anchors.centerIn: parent
            text: modelData; font: root.appFont; color: "#00ffcc"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Описания тем ─────────────────────────────────────────────────────────
    readonly property var themes: [
        {
            name: "Default",
            bgColor: "#f0f0f0",
            labelColor: "#ccc",
            delegate:       defaultDelegate,
            background:     defaultBackground,
            highlight:      defaultHighlight,
            highlightYear:  null,
            highlightMonth: null,
            highlightDay:   null
        },
        {
            name: "Minimal",
            bgColor: "#ffffff",
            labelColor: "#ccc",
            delegate:       minimalDelegate,
            background:     minimalBackground,
            highlight:      minimalHighlight,
            highlightYear:  null,
            highlightMonth: null,
            highlightDay:   null
        },
        {
            name: "Dark",
            bgColor: "#1e1e1e",
            labelColor: "#ccc",
            delegate:       darkDelegate,
            background:     darkBackground,
            highlight:      darkHighlight,
            highlightYear:  null,
            highlightMonth: null,
            highlightDay:   null
        },
        {
            name: "Neon",
            bgColor: "#0a0a1a",
            labelColor: "#ccc",
            delegate:       neonDelegate,
            background:     neonBackground,
            highlight:      neonHighlight,
            highlightYear:  null,
            highlightMonth: null,
            highlightDay:   null
        },
        {
            name: "Retro",
            bgColor: "#fdf5e6",
            labelColor: "#ccc",
            delegate:       retroDelegate,
            background:     retroBackground,
            highlight:      retroHighlight,
            highlightYear:  null,
            highlightMonth: null,
            highlightDay:   null
        },
        {
            name: "Neon2",
            bgColor: "#0a0a1a",
            labelColor: "#ccc",
            delegate:       neon2Delegate,
            background:     neonBackground,
            highlight:      null,
            highlightYear:  neon2HighlightYear,
            highlightMonth: neon2HighlightMonth,
            highlightDay:   neon2HighlightDay
        }
    ]

    // ── Разметка ──────────────────────────────────────────────────────────────
    GridLayout {
        anchors.fill: parent
        anchors.margins: 16
        // spacing: 12
        columns: 3

        Repeater {
            model: root.themes

            delegate: ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 6

                // Подпись темы
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: modelData.name
                    font.family: "Arial"
                    font.pointSize: 11
                    font.bold: true
                    color: modelData.labelColor
                }

                // Карточка с DatePicker
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: modelData.bgColor
                    radius: 8

                    // Рамка для светлых тем
                    border.color: modelData.bgColor === "#ffffff" || modelData.bgColor === "#f0f0f0"
                                  ? "#ddd" : "transparent"
                    border.width: 1

                    DatePicker {
                        anchors.fill: parent
                        anchors.margins: 8

                        font: root.appFont
                        // selectedDate:  root.sharedSelectedDate
                        dateRange:     root.sharedDateRange

                        delegate:       modelData.delegate
                        background:     modelData.background
                        highlight:      modelData.highlight
                        highlightYear:  modelData.highlightYear
                        highlightMonth: modelData.highlightMonth
                        highlightDay:   modelData.highlightDay

                        onActivated: (d) => root.sharedSelectedDate = d
                    }
                }
            }
        }
    }
}
