import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes
import Gai

Window {
    id: root
    width: 1400
    height: 900
    visible: true
    title: "Spinning Wheel Demo"
    color: "#f0f0f0"
    property font font: Qt.font({ family: "Arial", pointSize: 14 })

    property var currentLocale: Qt.locale()
    property var localeNames: ["en_US", "ru_RU", "de_DE", "fr_FR", "zh_CN", "ar_SA", "ja_JP"]

    // ── Events model ────────────────────────────────────────────────────────
    ListModel { id: eventLog }

    function appendEvent(source, signal, value) {
        eventLog.append({ text: "[" + source + "] " + signal + " → " + value })
        if (eventLog.count > 200)
            eventLog.remove(0)
    }

    // ── Themes: common components ────────────────────────────────────────────────
    Component {
        id: defaultHighlight
        Rectangle { color: "transparent"; border.color: "#409eff"; border.width: 1; radius: 6 }
    }
    Component { id: defaultBackground; Item {} }
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
        id: neonHighlight
        Rectangle { color: "#1100ffcc"; border.color: "#00ffcc"; border.width: 1; radius: 6 }
    }
    Component {
        id: neonBackground
        Rectangle {
            color: "#0a0a1a";
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
        id: neon2HighlightYear
        Shape {
            id: shapeYear
            ShapePath {
                strokeColor: "#00ffcc"
                strokeWidth: 1
                fillColor: "#2200ffcc"
                startX: shapeYear.width; startY: shapeYear.height
                PathLine { x: 6; y: shapeYear.height }
                PathArc  { x: 0; y: shapeYear.height - 6; radiusX: 6; radiusY: 6 }
                PathLine { x: 0; y: 6 }
                PathArc  { x: 6; y: 0; radiusX: 6; radiusY: 6 }
                PathLine { x: shapeYear.width; y: 0 }
            }
        }
    }
    Component {
        id: neon2HighlightMonth
        Shape {
            id: shapeMonth
            ShapePath {
                strokeColor: "transparent"
                strokeWidth: 0
                fillColor: "#2200ffcc"
                startX: 0; startY: 0
                PathLine { x: shapeMonth.width; y: 0 }
                PathLine { x: shapeMonth.width; y: shapeMonth.height }
                PathLine { x: 0; y: shapeMonth.height }
                PathLine { x: 0; y: 0 }
            }
            ShapePath {
                strokeColor: "#00ffcc"
                strokeWidth: 1
                fillColor: "transparent"
                startX: 0; startY: 0
                PathLine { x: shapeMonth.width; y: 0 }
            }
            ShapePath {
                strokeColor: "#00ffcc"
                strokeWidth: 1
                fillColor: "transparent"
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
                strokeColor: "#00ffcc"
                strokeWidth: 1
                fillColor: "#2200ffcc"
                startX: 0; startY: 0
                PathLine { x: shapeDay.width - 6; y: 0 }
                PathArc { x: shapeDay.width; y: 6; radiusX: 6; radiusY: 6 }
                PathLine { x: shapeDay.width; y: shapeDay.height - 6 }
                PathArc { x: shapeDay.width - 6; y: shapeDay.height; radiusX: 6; radiusY: 6 }
                PathLine { x: 0; y: shapeDay.height }
            }
        }
    }

    // ── Delegates ──────────────────────────────────────────────────────────────
    component TextDelegate: Text {
        anchors.centerIn: parent
        text: modelData
        font: root.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Component { id: w1DefaultDelegate; TextDelegate { color: "#222" } }
    Component { id: w1MinimalDelegate; TextDelegate { color: "#555" } }
    Component { id: w1DarkDelegate;    TextDelegate { color: "#eee" } }
    Component { id: w1NeonDelegate;    TextDelegate { color: "#00ffcc" } }
    Component { id: w1RetroDelegate;   TextDelegate { color: "#3d2b00"; font.family: "Courier"; font.pointSize: root.font.pointSize } }

    Component { id: w2DefaultDelegate; TextDelegate { color: "#222" } }
    Component { id: w2MinimalDelegate; TextDelegate { color: "#555" } }
    Component { id: w2DarkDelegate;    TextDelegate { color: "#eee" } }
    Component { id: w2NeonDelegate;    TextDelegate { color: "#00ffcc" } }
    Component { id: w2RetroDelegate;   TextDelegate { color: "#3d2b00"; font.family: "Courier"; font.pointSize: root.font.pointSize } }

    component EmojiDelegate: Item {
        width: parent ? parent.width : 0
        height: parent ? parent.height : 0
        property color textColor: "#222"
        Row {
            anchors.centerIn: parent
            spacing: 6
            Text { text: model.emoji; font.pointSize: 14; verticalAlignment: Text.AlignVCenter }
            Text { text: model.label; font: root.font; color: parent.parent.textColor; verticalAlignment: Text.AlignVCenter }
        }
    }

    Component { id: defaultDelegate; EmojiDelegate { textColor: "#222" } }
    Component { id: darkDelegate;    EmojiDelegate { textColor: "#eee" } }
    Component { id: neonDelegate;    EmojiDelegate { textColor: "#00ffcc" } }
    Component { id: retroDelegate;   EmojiDelegate { textColor: "#3d2b00" } }
    Component {
        id: minimalDelegate
        Text {
            anchors.centerIn: parent
            text: model.label; font: root.font; color: "#555"
            horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Theme tables ──────────────────────────────────────────────────────────
    property var themeNames: ["Default", "Minimal", "Dark", "Neon", "Retro"]

    property var themesW1: [
        { delegate: w1DefaultDelegate, highlight: defaultHighlight, background: defaultBackground },
        { delegate: w1MinimalDelegate, highlight: minimalHighlight, background: minimalBackground },
        { delegate: w1DarkDelegate,    highlight: darkHighlight,    background: darkBackground    },
        { delegate: w1NeonDelegate,    highlight: neonHighlight,    background: neonBackground    },
        { delegate: w1RetroDelegate,   highlight: retroHighlight,   background: retroBackground   }
    ]
    property var themesW2: [
        { delegate: w2DefaultDelegate, highlight: defaultHighlight, background: defaultBackground },
        { delegate: w2MinimalDelegate, highlight: minimalHighlight, background: minimalBackground },
        { delegate: w2DarkDelegate,    highlight: darkHighlight,    background: darkBackground    },
        { delegate: w2NeonDelegate,    highlight: neonHighlight,    background: neonBackground    },
        { delegate: w2RetroDelegate,   highlight: retroHighlight,   background: retroBackground   }
    ]
    property var themesW3: [
        { delegate: defaultDelegate, highlight: defaultHighlight, background: defaultBackground },
        { delegate: minimalDelegate, highlight: minimalHighlight, background: minimalBackground },
        { delegate: darkDelegate,    highlight: darkHighlight,    background: darkBackground    },
        { delegate: neonDelegate,    highlight: neonHighlight,    background: neonBackground    },
        { delegate: retroDelegate,   highlight: retroHighlight,   background: retroBackground   }
    ]
    property var themesMP: [
        { delegate: w1DefaultDelegate, highlight: defaultHighlight, background: defaultBackground },
        { delegate: w1MinimalDelegate, highlight: minimalHighlight, background: minimalBackground },
        { delegate: w1DarkDelegate,    highlight: darkHighlight,    background: darkBackground    },
        { delegate: w1NeonDelegate,    highlight: neonHighlight,    background: neonBackground    },
        { delegate: w1RetroDelegate,   highlight: retroHighlight,   background: retroBackground   }
    ]
    property var themesDP: [
        { delegate: w1DefaultDelegate, highlight: defaultHighlight, hY: null,               hM: null,                hD: null,             background: defaultBackground },
        { delegate: w1MinimalDelegate, highlight: minimalHighlight, hY: null,               hM: null,                hD: null,             background: minimalBackground },
        { delegate: w1DarkDelegate,    highlight: darkHighlight,    hY: null,               hM: null,                hD: null,             background: darkBackground    },
        { delegate: w1NeonDelegate,    highlight: neonHighlight,    hY: null,               hM: null,                hD: null,             background: neonBackground    },
        { delegate: w1RetroDelegate,   highlight: retroHighlight,   hY: null,               hM: null,                hD: null,             background: retroBackground   },
        { delegate: w1NeonDelegate,    highlight: null,             hY: neon2HighlightYear, hM: neon2HighlightMonth, hD: neon2HighlightDay, background: neonBackground   }
    ]

    // ── Layout ────────────────────────────────────────────────────────────────
    RowLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 12

            // ── Control panel ─────────────────────────────────────────────
            RowLayout {
                spacing: 12
                Layout.fillWidth: true

                Text { text: "Locale:"; font.pointSize: 10; color: "#555" }
                ComboBox {
                    id: localePicker
                    model: localeNames
                    font.pointSize: 10
                    onCurrentIndexChanged: root.currentLocale = Qt.locale(localeNames[currentIndex])
                }

                Item { Layout.fillWidth: true }
            }

            // ── Three spinning wheels ────────────────────────────────────────────────────
            GroupBox {
                title: "Spinning Wheels"
                Layout.fillWidth: true
                Layout.fillHeight: true

                RowLayout {
                    anchors.fill: parent
                    spacing: 12

                    // Wheel 1
                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 4

                        ComboBox {
                            id: themePickerW1
                            Layout.fillWidth: true
                            model: themeNames
                            font.pointSize: 10
                        }
                        SpinningWheel {
                            id: wheel1
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font: root.font
                            locale: root.currentLocale
                            model: 10
                            delegate:   themesW1[themePickerW1.currentIndex].delegate
                            highlight:  themesW1[themePickerW1.currentIndex].highlight
                            background: themesW1[themePickerW1.currentIndex].background
                            onActivated: (i) => appendEvent("Wheel1", "activated", i)
                            onCurrentIndexChanged: appendEvent("Wheel1", "indexChanged", currentIndex)
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.fillWidth: true
                            text: "Index: " + wheel1.currentIndex
                            font.pointSize: 9
                            font.bold: true
                            color: "#0055aa"
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    // Wheel 2
                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 4

                        ComboBox {
                            id: themePickerW2
                            Layout.fillWidth: true
                            model: themeNames
                            font.pointSize: 10
                        }
                        SpinningWheel {
                            id: wheel2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font: root.font
                            locale: root.currentLocale
                            model: ["Apples", "Pears", "Bananas", "Peaches", "Grapes", "Watermelon"]
                            delegate:   themesW2[themePickerW2.currentIndex].delegate
                            highlight:  themesW2[themePickerW2.currentIndex].highlight
                            background: themesW2[themePickerW2.currentIndex].background
                            onActivated: (i) => appendEvent("Wheel2", "activated", model[i])
                            onCurrentIndexChanged: appendEvent("Wheel2", "indexChanged",
                                model[currentIndex] + " (" + currentIndex + ")")
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.fillWidth: true
                            text: wheel2.model[wheel2.currentIndex] + " (" + wheel2.currentIndex + ")"
                            font.pointSize: 9
                            font.bold: true
                            color: "#0055aa"
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }
                    }

                    // Wheel 3
                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 4

                        ComboBox {
                            id: themePickerW3
                            Layout.fillWidth: true
                            model: themeNames
                            font.pointSize: 10
                        }
                        SpinningWheel {
                            id: wheel3
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font: root.font
                            locale: root.currentLocale
                            model: ListModel {
                                ListElement { emoji: "🍎"; label: "Apple"  }
                                ListElement { emoji: "🍐"; label: "Pear"   }
                                ListElement { emoji: "🍌"; label: "Banana" }
                                ListElement { emoji: "🍑"; label: "Peach"  }
                                ListElement { emoji: "🍇"; label: "Grapes" }
                                ListElement { emoji: "🍓"; label: "Berry"  }
                            }
                            delegate:   themesW3[themePickerW3.currentIndex].delegate
                            highlight:  themesW3[themePickerW3.currentIndex].highlight
                            background: themesW3[themePickerW3.currentIndex].background
                            onActivated: (i) => appendEvent("Wheel3", "activated",
                                model.get(i).label + " (" + i + ")")
                            onCurrentIndexChanged: appendEvent("Wheel3", "indexChanged",
                                model.get(currentIndex).label + " (" + currentIndex + ")")
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.fillWidth: true
                            text: wheel3.model.get(wheel3.currentIndex).label
                                + " (" + wheel3.currentIndex + ")"
                            font.pointSize: 9
                            font.bold: true
                            color: "#0055aa"
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }
                    }
                }
            }

            // ── MonthPicker ───────────────────────────────────────────────────
            GroupBox {
                title: "MonthPicker"
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 8

                    RowLayout {
                        spacing: 8

                        ComboBox {
                            id: themePickerMP
                            model: themeNames
                            font.pointSize: 10
                        }

                        ComboBox {
                            id: monthRangePicker
                            font.pointSize: 10
                            model: ListModel {
                                ListElement { label: "All (1–12)";   from: 0; to: 11 }
                                ListElement { label: "Q1 (1–3)";     from: 0; to: 2  }
                                ListElement { label: "Q2 (4–6)";     from: 3; to: 5  }
                                ListElement { label: "Q3 (7–9)";     from: 6; to: 8  }
                                ListElement { label: "Q4 (10–12)";   from: 9; to: 11 }
                                ListElement { label: "H1 (1–6)";     from: 0; to: 5  }
                                ListElement { label: "H2 (7–12)";    from: 6; to: 11 }
                                ListElement { label: "Single (Jun)"; from: 5; to: 5  }
                            }
                            textRole: "label"
                            onCurrentIndexChanged: {
                                let r = model.get(currentIndex)
                                monthPicker1.range = { from: r.from, to: r.to }
                            }
                        }

                        Text {
                            text: root.currentLocale.standaloneMonthName(monthPicker1.currentMonth, Locale.LongFormat)
                                + " (" + monthPicker1.currentMonth + ")"
                            font.pointSize: 10
                            font.bold: true
                            color: "#0055aa"
                            Layout.minimumWidth: {
                                let max = 0
                                for (let i = 0; i <= 11; i++) {
                                    let w = monthNameMetrics.advanceWidth(
                                        root.currentLocale.standaloneMonthName(i, Locale.LongFormat) + " (11)")
                                    if (w > max) max = w
                                }
                                return max
                            }
                        }

                        FontMetrics { id: monthNameMetrics; font.pointSize: 10 }

                        Item { Layout.fillWidth: true }
                    }

                    MonthPicker {
                        id: monthPicker1
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        font: root.font
                        locale: root.currentLocale
                        range: ({ from: 0, to: 11 })
                        currentMonth: 5
                        delegate:   themesMP[themePickerMP.currentIndex].delegate
                        highlight:  themesMP[themePickerMP.currentIndex].highlight
                        background: themesMP[themePickerMP.currentIndex].background
                        onCurrentMonthChanged: appendEvent("MonthPicker", "currentMonthChanged",
                            root.currentLocale.standaloneMonthName(currentMonth, Locale.LongFormat)
                            + " (" + currentMonth + ")")
                        onActivated: (m) => appendEvent("MonthPicker", "activated",
                            root.currentLocale.standaloneMonthName(m, Locale.LongFormat) + " (" + m + ")")
                    }
                }
            }

            // ── DatePicker ────────────────────────────────────────────────────
            GroupBox {
                title: "DatePicker"
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 8

                    RowLayout {
                        spacing: 8

                        ComboBox {
                            id: themePickerDP
                            model: ["Default", "Minimal", "Dark", "Neon", "Retro", "Neon2"]
                            font.pointSize: 10
                        }

                        Text {
                            text: datePicker1.selectedDate.toLocaleDateString(root.currentLocale)
                            font.pointSize: 10
                            font.bold: true
                            color: "#0055aa"
                            Layout.minimumWidth: 180
                        }

                        Item { Layout.fillWidth: true }

                        Button {
                            text: "Next range"
                            font.pointSize: 10
                            onClicked: {
                                let i = (datePicker1.dateIndex++) % 3
                                switch (i) {
                                    case 0:
                                        datePicker1.dateRange = { begin: new Date(2026,1,1), end: new Date(2026,11,31) }
                                        datePicker1.selectedDate = new Date(2026,5,5); break
                                    case 1:
                                        datePicker1.dateRange = { begin: new Date(2026,0,1), end: new Date(2027,10,20) }
                                        datePicker1.selectedDate = new Date(2026,8,8); break
                                    case 2:
                                        datePicker1.dateRange = { begin: new Date(2026,6,1), end: new Date(2026,5,10) }
                                        datePicker1.selectedDate = new Date(2026,10,10); break
                                }
                            }
                        }
                    }

                    DatePicker {
                        id: datePicker1
                        property int dateIndex: 0
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        font: root.font
                        locale: root.currentLocale
                        selectedDate: new Date(2026, 4, 8)
                        dateRange: ({ begin: new Date(2020,0,1), end: new Date(2030,11,31) })

                        delegate:       themesDP[themePickerDP.currentIndex].delegate
                        background:     themesDP[themePickerDP.currentIndex].background
                        highlight:      themesDP[themePickerDP.currentIndex].highlight
                        highlightYear:  themesDP[themePickerDP.currentIndex].hY
                        highlightMonth: themesDP[themePickerDP.currentIndex].hM
                        highlightDay:   themesDP[themePickerDP.currentIndex].hD

                        onSelectedDateChanged: appendEvent("DatePicker", "selectedDateChanged",
                            selectedDate.toLocaleDateString(root.currentLocale))
                        onActivated: (d) => appendEvent("DatePicker", "activated",
                            d.toLocaleDateString(root.currentLocale))
                    }
                }
            }
        }

        // ── Event log ───────────────────────────────────────────────────────
        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: 320
            spacing: 6

            RowLayout {
                Text { text: "Event log"; font.pointSize: 11; font.bold: true; Layout.fillWidth: true }
                Button {
                    text: "Clear"; flat: true; font.pointSize: 10
                    onClicked: eventLog.clear()
                }
            }

            ListView {
                id: eventListView
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: eventLog
                boundsBehavior: Flickable.StopAtBounds
                onCountChanged: positionViewAtEnd()

                delegate: RowLayout {
                    width: eventListView.width
                    spacing: 6
                    Rectangle {
                        width: 8; height: 8; radius: 4
                        Layout.alignment: Qt.AlignVCenter
                        color: model.text.includes("activated")       ? "#0066cc"
                             : model.text.startsWith("[DatePicker]")  ? "#cc6600"
                             : model.text.startsWith("[MonthPicker]") ? "#007755"
                             : model.text.startsWith("[Wheel")        ? "#7700aa"
                             : "#888"
                    }
                    Text {
                        text: model.text
                        font.pointSize: 9
                        color: model.text.includes("activated")       ? "#0066cc"
                             : model.text.startsWith("[DatePicker]")  ? "#cc6600"
                             : model.text.startsWith("[MonthPicker]") ? "#007755"
                             : model.text.startsWith("[Wheel")        ? "#7700aa"
                             : "#444"
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }
}
