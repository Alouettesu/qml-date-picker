import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import Gai

Window {
    id: root
    width: 1100
    height: 800
    visible: true
    title: "DatePicker Demo"
    color: "#f0f0f0"
    property font font: Qt.font({ family: "Arial", pixelSize: 20})

    function nextRange() {
        let rangeIndex = (datePicker1.dateIndex++) % 3
        switch (rangeIndex) {
            case 0:
                datePicker1.dateRange = { begin: new Date(2026, 1, 1), end: new Date(2026, 11, 31) }
                datePicker1.selectedDate = new Date(2026, 5, 5)
                break
            case 1:
                datePicker1.dateRange = { begin: new Date(2026, 0, 1), end: new Date(2027, 10, 20) }
                datePicker1.selectedDate = new Date(2026, 8, 8)
                break
            case 2:
                // Invalid range - must be discarded
                datePicker1.dateRange = { begin: new Date(2026, 6, 1), end: new Date(2026, 5, 10) }
                datePicker1.selectedDate = new Date(2026, 10, 10)
                break
        }
    }

    function nextMonthRange() {
        let rangeIndex = (monthPicker1.monthIndex++) % 12
        switch (rangeIndex) {
            case 0:  monthPicker1.range = {from: 1, to: 11}; monthPicker1.currentMonth = 5;  break
            case 1:  monthPicker1.range = {from: 0, to: 10};                                  break
            case 2:  monthPicker1.currentMonth = 2;                                            break
            case 3:  monthPicker1.range = {from: 0, to: 6};  monthPicker1.currentMonth = 10; break
            case 4:  monthPicker1.range = {from: 5, to: 11}; monthPicker1.currentMonth = 2;  break
            case 5:  monthPicker1.range = {from: 3, to: 3};  monthPicker1.currentMonth = 3;  break
            case 6:  monthPicker1.range = {from: 7, to: 7};  monthPicker1.currentMonth = 0;  break
            case 7:  monthPicker1.currentMonth = 9; monthPicker1.range = {from: 2, to: 8};   break
            case 8:  monthPicker1.range = {from: 0, to: 3};  monthPicker1.currentMonth = 3;  break
            case 9:  monthPicker1.range = {from: 0, to: 11}; monthPicker1.currentMonth = 11; break
            case 10: monthPicker1.range = {from: 4, to: 9};  monthPicker1.currentMonth = 4;  break
            case 11: monthPicker1.range = {from: 4, to: 9};  monthPicker1.currentMonth = 9;  break
        }
    }

    ListModel { id: eventLog }

    // ── Wheel 1  ───────────────────────────────────────────────
    Component {
        id: w1DefaultDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#222"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w1MinimalDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#555"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w1DarkDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#eee"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w1NeonDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#00ffcc"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w1RetroDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font.family: "Courier"; font.pixelSize: root.font.pixelSize
            color: "#3d2b00"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Wheel 2  ────────────────────────────────────────────
    Component {
        id: w2DefaultDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#222"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w2MinimalDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#555"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w2DarkDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#eee"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w2NeonDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font: root.font; color: "#00ffcc"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: w2RetroDelegate
        Text {
            anchors.centerIn: parent
            text: modelData
            font.family: "Courier"; font.pixelSize: root.font.pixelSize
            color: "#3d2b00"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // ── Wheel 3 ──────────────────────────────────────────────────────────────────
    // ── Default ───────────────────────────────────────────────────────────────────
    Component {
        id: defaultDelegate
        Item {
            width: parent ? parent.width : 0
            height: parent ? parent.height : 0
            Row {
                anchors.centerIn: parent
                spacing: 6
                Text { text: model.emoji; font.pixelSize: 18; verticalAlignment: Text.AlignVCenter }
                Text { text: model.label; font: root.font; color: "#222"; verticalAlignment: Text.AlignVCenter }
            }
        }
    }
    Component {
        id: defaultHighlight
        Rectangle { color: "transparent"; border.color: "#409eff"; border.width: 1; radius: 6 }
    }
    Component {
        id: defaultBackground
        Item {}
    }

    // ── Minimal ───────────────────────────────────────────────────────────────────
    Component {
        id: minimalDelegate
        Text {
            anchors.centerIn: parent
            text: model.label
            font: root.font
            color: "#555"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component {
        id: minimalHighlight
        Item {
            Rectangle {
                anchors.left: parent.left; anchors.right: parent.right
                anchors.leftMargin: 8;    anchors.rightMargin: 8
                height: 1; color: "#bbb"
                anchors.top: parent.top
            }
            Rectangle {
                anchors.left: parent.left; anchors.right: parent.right
                anchors.leftMargin: 8;    anchors.rightMargin: 8
                height: 1; color: "#bbb"
                anchors.bottom: parent.bottom
            }
        }
    }
    Component {
        id: minimalBackground
        Item {}
    }

    // ── Dark ──────────────────────────────────────────────────────────────────────
    Component {
        id: darkDelegate
        Item {
            width: parent ? parent.width : 0
            height: parent ? parent.height : 0
            Row {
                anchors.centerIn: parent
                spacing: 6
                Text { text: model.emoji; font.pixelSize: 18; verticalAlignment: Text.AlignVCenter }
                Text { text: model.label; font: root.font; color: "#eee"; verticalAlignment: Text.AlignVCenter }
            }
        }
    }
    Component {
        id: darkHighlight
        Rectangle { color: "#18ffffff"; border.color: "#44ffffff"; border.width: 1; radius: 6 }
    }
    Component {
        id: darkBackground
        Rectangle {
            radius: 8
            color: "#1e1e1e"
            // Градиентные маски сверху и снизу
            Rectangle {
                anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#e01e1e1e" }
                    GradientStop { position: 1.0; color: "#001e1e1e" }
                }
                z: 1
            }
            Rectangle {
                anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#001e1e1e" }
                    GradientStop { position: 1.0; color: "#e01e1e1e" }
                }
                z: 1
            }
        }
    }

    // ── Neon ──────────────────────────────────────────────────────────────────────
    Component {
        id: neonDelegate
        Item {
            width: parent ? parent.width : 0
            height: parent ? parent.height : 0
            Row {
                anchors.centerIn: parent
                spacing: 6
                Text { text: model.emoji; font.pixelSize: 18; verticalAlignment: Text.AlignVCenter }
                Text { text: model.label; font: root.font; color: "#00ffcc"; verticalAlignment: Text.AlignVCenter }
            }
        }
    }

    Component {
        id: neonHighlight
        Rectangle {
            color: "#220d00ff"
            border.color: "#00ffcc"
            border.width: 1
            radius: 6
        }
    }
    Component {
        id: neonBackground
        Rectangle {
            color: "#0a0a1a"
            radius: 8
            Rectangle {
                anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.35
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#e00a0a1a" }
                    GradientStop { position: 1.0; color: "#000a0a1a" }
                }
                z: 1
            }
            Rectangle {
                anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.35
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#000a0a1a" }
                    GradientStop { position: 1.0; color: "#e00a0a1a" }
                }
                z: 1
            }
        }
    }

    // ── Retro ─────────────────────────────────────────────────────────────────────
    Component {
        id: retroDelegate
        Item {
            width: parent ? parent.width : 0
            height: parent ? parent.height : 0
            Row {
                anchors.centerIn: parent
                spacing: 6
                Text { text: model.emoji; font.pixelSize: 18; verticalAlignment: Text.AlignVCenter }
                Text {
                    text: model.label
                    font.family: "Courier"; font.pixelSize: root.font.pixelSize
                    color: "#3d2b00"
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    Component {
        id: retroHighlight
        Rectangle {
            color: "#a0ffe0b2"
            border.color: "#bf6c00"
            border.width: 2
            radius: 3
        }
    }
    Component {
        id: retroBackground
        Rectangle {
            color: "#fdf5e6"
            radius: 4
            border.color: "#d4a96a"
            border.width: 1
            Rectangle {
                anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#fffdf5e6" }
                    GradientStop { position: 1.0; color: "#00fdf5e6" }
                }
                z: 1
            }
            Rectangle {
                anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00fdf5e6" }
                    GradientStop { position: 1.0; color: "#fffdf5e6" }
                }
                z: 1
            }
        }
    }

    function appendEvent(source, signal, value) {
        eventLog.append({ text: "[" + source + "] " + signal + " → " + value })
        if (eventLog.count > 100)
            eventLog.remove(0)
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "DatePicker Component Demo"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        GroupBox {
            title: "DatePicker"
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                RowLayout {
                    spacing: 10

                    Button {
                        text: "Next range"
                        onClicked: nextRange()
                    }

                    Text {
                        text: "Range: "
                            + datePicker1.dateRange.begin.toLocaleDateString()
                            + " → "
                            + datePicker1.dateRange.end.toLocaleDateString()
                        font.pixelSize: 12
                        color: "#666"
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    GroupBox {
                        title: "DatePicker"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        DatePicker {
                            id: datePicker1
                            property int dateIndex: 0
                            anchors.fill: parent
                            selectedDate: new Date(2026, 4, 8)
                            dateRange: ({ begin: new Date(2020, 0, 1), end: new Date(2030, 11, 31) })

                            onSelectedDateChanged: {
                                appendEvent("DatePicker", "selectedDateChanged",
                                    selectedDate.toLocaleDateString())
                            }
                            onActivated: (d) => {
                                appendEvent("DatePicker", "activated",
                                    d.toLocaleDateString())
                            }
                        }
                    }
                    GroupBox {
                        title: "Spinning Wheel 1"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 8

                            ComboBox {
                                id: themePickerW1
                                Layout.fillWidth: true
                                model: ["Default", "Minimal", "Dark", "Neon", "Retro"]
                            }

                            SpinningWheel {
                                id: wheel
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                model: 10

                                property var themes: [
                                    { delegate: w1DefaultDelegate, highlight: defaultHighlight, background: defaultBackground },
                                    { delegate: w1MinimalDelegate, highlight: minimalHighlight, background: minimalBackground },
                                    { delegate: w1DarkDelegate,    highlight: darkHighlight,    background: darkBackground    },
                                    { delegate: w1NeonDelegate,    highlight: neonHighlight,    background: neonBackground    },
                                    { delegate: w1RetroDelegate,   highlight: retroHighlight,   background: retroBackground   }
                                ]

                                delegate:   themes[themePickerW1.currentIndex].delegate
                                highlight:  themes[themePickerW1.currentIndex].highlight
                                background: themes[themePickerW1.currentIndex].background
                            }
                        }
                    }

                    GroupBox {
                        title: "Spinning Wheel 2"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 8

                            ComboBox {
                                id: themePickerW2
                                Layout.fillWidth: true
                                model: ["Default", "Minimal", "Dark", "Neon", "Retro"]
                            }

                            SpinningWheel {
                                id: wheel1
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                model: ["Apples", "Pears", "Bananas", "Peaches", "Grapes", "Watermelon"]

                                property var themes: [
                                    { delegate: w2DefaultDelegate, highlight: defaultHighlight, background: defaultBackground },
                                    { delegate: w2MinimalDelegate, highlight: minimalHighlight, background: minimalBackground },
                                    { delegate: w2DarkDelegate,    highlight: darkHighlight,    background: darkBackground    },
                                    { delegate: w2NeonDelegate,    highlight: neonHighlight,    background: neonBackground    },
                                    { delegate: w2RetroDelegate,   highlight: retroHighlight,   background: retroBackground   }
                                ]

                                delegate:   themes[themePickerW2.currentIndex].delegate
                                highlight:  themes[themePickerW2.currentIndex].highlight
                                background: themes[themePickerW2.currentIndex].background
                            }
                        }
                    }

                    GroupBox {
                        title: "Spinning Wheel 3 — Custom"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 8

                            ComboBox {
                                id: themePicker
                                Layout.fillWidth: true
                                model: ["Default", "Minimal", "Dark", "Neon", "Retro"]
                            }

                            SpinningWheel {
                                id: wheel2
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                model: ListModel {
                                    ListElement { emoji: "🍎"; label: "Apple"  }
                                    ListElement { emoji: "🍐"; label: "Pear"   }
                                    ListElement { emoji: "🍌"; label: "Banana" }
                                    ListElement { emoji: "🍑"; label: "Peach"  }
                                    ListElement { emoji: "🍇"; label: "Grapes" }
                                    ListElement { emoji: "🍓"; label: "Berry"  }
                                }

                                property var themes: [
                                    { delegate: defaultDelegate, highlight: defaultHighlight, background: defaultBackground },
                                    { delegate: minimalDelegate, highlight: minimalHighlight, background: minimalBackground },
                                    { delegate: darkDelegate,    highlight: darkHighlight,    background: darkBackground    },
                                    { delegate: neonDelegate,    highlight: neonHighlight,    background: neonBackground    },
                                    { delegate: retroDelegate,   highlight: retroHighlight,   background: retroBackground   }
                                ]

                                delegate:   themes[themePicker.currentIndex].delegate
                                highlight:  themes[themePicker.currentIndex].highlight
                                background: themes[themePicker.currentIndex].background
                            }
                        }
                    }
                }
            }
        }

        // ── MonthPicker ──────────────────────────────────────────
        GroupBox {
            title: "MonthPicker"
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                RowLayout {
                    spacing: 10

                    Button {
                        text: "Next range"
                        onClicked: nextMonthRange()
                    }

                    Text {
                        text: "Range: Month " + (monthPicker1.fromMonth + 1)
                            + " → " + (monthPicker1.toMonth + 1)
                        font.pixelSize: 12
                        color: "#666"
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    GroupBox {
                        title: "MonthPicker"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        MonthPicker {
                            id: monthPicker1
                            property int monthIndex: 0
                            anchors.fill: parent
                            currentMonth: 5
                            range: ({ from: 0, to: 11 })

                            onCurrentMonthChanged: {
                                appendEvent("MonthPicker", "currentMonthChanged",
                                    Qt.locale().standaloneMonthName(currentMonth, Locale.LongFormat)
                                    + " (" + currentMonth + ")")
                            }
                            onActivated: (month) => {
                                appendEvent("MonthPicker", "activated",
                                    Qt.locale().standaloneMonthName(month, Locale.LongFormat)
                                    + " (" + month + ")")
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.fillHeight: true
                        spacing: 10

                        Text { text: "Selected Month:"; font.bold: true }
                        Text {
                            text: Qt.locale().standaloneMonthName(monthPicker1.currentMonth, Locale.LongFormat)
                            font.pixelSize: 14
                            color: "#0066cc"
                        }
                        Text {
                            text: "Index: " + monthPicker1.currentMonth
                            font.pixelSize: 12; color: "#666"
                        }
                        Text {
                            text: "Test " + monthPicker1.monthIndex + " / 12"
                            font.pixelSize: 11; color: "#888"
                        }
                        Text {
                            text: {
                                let ok = monthPicker1.currentMonth >= monthPicker1.fromMonth
                                      && monthPicker1.currentMonth <= monthPicker1.toMonth
                                return ok ? "✓ Within range" : "✗ Out of range!"
                            }
                            font.pixelSize: 11
                            font.bold: true
                            color: monthPicker1.currentMonth >= monthPicker1.fromMonth
                                && monthPicker1.currentMonth <= monthPicker1.toMonth
                                ? "#00aa00" : "#aa0000"
                        }
                        Item { Layout.fillHeight: true }
                    }

                    ColumnLayout {
                        Layout.fillHeight: true
                        spacing: 6
                        implicitWidth: 300

                        RowLayout {
                            Text { text: "Event log:"; font.bold: true; Layout.fillWidth: true }
                            Button {
                                text: "Clear"
                                flat: true
                                font.pixelSize: 11
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
                                    color: model.text.includes("activated") ? "#0066cc"
                                         : model.text.startsWith("[DatePicker]") ? "#cc6600"
                                         : "#888"
                                }

                                Text {
                                    text: model.text
                                    font.pixelSize: 11
                                    color: model.text.includes("activated") ? "#0066cc"
                                         : model.text.startsWith("[DatePicker]") ? "#cc6600"
                                         : "#444"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
