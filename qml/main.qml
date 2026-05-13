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

        // ── Test Case 1: DatePicker ───────────────────────────────────────────
        GroupBox {
            title: "Test Case 1: DatePicker"
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

                    ColumnLayout {
                        Layout.fillHeight: true
                        spacing: 10

                        Text { text: "Selected Date:"; font.bold: true }
                        Text {
                            text: datePicker1.selectedDate.toLocaleDateString()
                            font.pixelSize: 14
                            color: "#0066cc"
                        }

                        Text {
                            text: {
                                let d = datePicker1.selectedDate
                                let b = datePicker1.dateRange.begin
                                let e = datePicker1.dateRange.end
                                let ok = d >= b && d <= e
                                return ok ? "✓ Within range" : "✗ Out of range!"
                            }
                            font.pixelSize: 11
                            font.bold: true
                            color: {
                                let d = datePicker1.selectedDate
                                let b = datePicker1.dateRange.begin
                                let e = datePicker1.dateRange.end
                                return d >= b && d <= e ? "#00aa00" : "#aa0000"
                            }
                        }

                        Item { Layout.fillHeight: true }
                    }
                }
            }
        }

        // ── Test Case 2: MonthPicker ──────────────────────────────────────────
        GroupBox {
            title: "Test Case 2: MonthPicker"
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

                    // ── Общий лог событий ─────────────────────────────────────
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
