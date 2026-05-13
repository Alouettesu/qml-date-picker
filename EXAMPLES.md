# Examples

## Basic Date Picker

The simplest way to use the DatePicker component:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 400
    height: 500
    visible: true
    title: "Simple Date Picker"

    DatePicker {
        anchors.centerIn: parent
        selectedDate: new Date(2026, 5, 15)
    }
}
```

## Date Picker with Custom Range

Set a specific date range for selection:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 400
    height: 500
    visible: true
    title: "Date Picker with Range"

    DatePicker {
        anchors.centerIn: parent
        
        selectedDate: new Date(2026, 5, 15)
        dateRange: {
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        }
    }
}
```

## Date Picker with Signal Handling

Respond to date selection:

```qml
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Gai

Window {
    width: 400
    height: 600
    visible: true
    title: "Date Picker with Signal"

    Column {
        anchors.centerIn: parent
        spacing: 20

        DatePicker {
            id: datePicker
            selectedDate: new Date(2026, 5, 15)
            
            onActivated: (selected) => {
                selectedDateText.text = selected.toLocaleDateString()
            }
        }

        Text {
            id: selectedDateText
            text: "Selected: " + datePicker.selectedDate.toLocaleDateString()
            font.pixelSize: 16
        }
    }
}
```

## Individual Year Picker

Use YearPicker standalone:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Year Picker"

    YearPicker {
        anchors.centerIn: parent
        currentYear: 2026
        range: { from: 2020, to: 2030 }
    }
}
```

## Individual Month Picker

Use MonthPicker standalone:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Month Picker"

    MonthPicker {
        anchors.centerIn: parent
        currentMonth: 5  // June (0-indexed)
        range: { from: 0, to: 11 }
    }
}
```

## Individual Day Picker

Use DayPicker standalone:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Day Picker"

    DayPicker {
        anchors.centerIn: parent
        currentDay: 15
        range: { from: 1, to: 31 }
    }
}
```

## Multiple Date Pickers

Use multiple pickers in one application:

```qml
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import Gai

Window {
    width: 900
    height: 500
    visible: true
    title: "Multiple Date Pickers"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Column {
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: "Start Date"
                font.bold: true
            }

            DatePicker {
                id: startDatePicker
                selectedDate: new Date(2026, 0, 1)
                dateRange: {
                    begin: new Date(2020, 0, 1),
                    end: new Date(2030, 11, 31)
                }
            }
        }

        Column {
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: "End Date"
                font.bold: true
            }

            DatePicker {
                id: endDatePicker
                selectedDate: new Date(2026, 11, 31)
                dateRange: {
                    begin: new Date(2020, 0, 1),
                    end: new Date(2030, 11, 31)
                }
            }
        }
    }
}
```

## Date Picker with Locale Support

Use different locales for month names:

```qml
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Gai

Window {
    width: 500
    height: 600
    visible: true
    title: "Date Picker with Locales"

    Column {
        anchors.centerIn: parent
        spacing: 20

        ComboBox {
            id: localeCombo
            model: ["en_US", "fr_FR", "de_DE", "es_ES", "ru_RU"]
            
            onCurrentTextChanged: {
                datePicker.locale = Qt.locale(currentText)
            }
        }

        DatePicker {
            id: datePicker
            selectedDate: new Date(2026, 5, 15)
            locale: Qt.locale("en_US")
        }
    }
}
```

## Dynamic Date Range

Change date range dynamically:

```qml
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Gai

Window {
    width: 500
    height: 600
    visible: true
    title: "Dynamic Date Range"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Row {
            spacing: 10

            Button {
                text: "2020-2025"
                onClicked: {
                    datePicker.dateRange = {
                        begin: new Date(2020, 0, 1),
                        end: new Date(2025, 11, 31)
                    }
                }
            }

            Button {
                text: "2025-2030"
                onClicked: {
                    datePicker.dateRange = {
                        begin: new Date(2025, 0, 1),
                        end: new Date(2030, 11, 31)
                    }
                }
            }

            Button {
                text: "2020-2030"
                onClicked: {
                    datePicker.dateRange = {
                        begin: new Date(2020, 0, 1),
                        end: new Date(2030, 11, 31)
                    }
                }
            }
        }

        DatePicker {
            id: datePicker
            selectedDate: new Date(2026, 5, 15)
            dateRange: {
                begin: new Date(2020, 0, 1),
                end: new Date(2030, 11, 31)
            }
        }
    }
}
```

## Date Picker with Custom Styling

Customize appearance:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 400
    height: 500
    visible: true
    title: "Styled Date Picker"

    DatePicker {
        anchors.centerIn: parent
        
        selectedDate: new Date(2026, 5, 15)
        dateRange: {
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        }
        
        font {
            family: "Arial"
            pixelSize: 18
            bold: true
        }
    }
}
```

## Date Picker in Dialog

Use date picker in a dialog:

```qml
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Gai

Window {
    width: 600
    height: 400
    visible: true
    title: "Date Picker Dialog"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Button {
            text: "Select Date"
            onClicked: dateDialog.open()
        }

        Text {
            id: selectedDateText
            text: "No date selected"
            font.pixelSize: 16
        }
    }

    Dialog {
        id: dateDialog
        title: "Select a Date"
        modal: true
        anchors.centerIn: parent

        DatePicker {
            id: dialogDatePicker
            selectedDate: new Date()
        }

        footer: DialogButtonBox {
            Button {
                text: "OK"
                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                onClicked: {
                    selectedDateText.text = "Selected: " + 
                        dialogDatePicker.selectedDate.toLocaleDateString()
                    dateDialog.close()
                }
            }

            Button {
                text: "Cancel"
                DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
                onClicked: dateDialog.close()
            }
        }
    }
}
```

## Date Range Picker

Create a date range picker using two DatePicker components:

```qml
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import Gai

Window {
    width: 900
    height: 600
    visible: true
    title: "Date Range Picker"

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "Select Date Range"
            font.pixelSize: 20
            font.bold: true
        }

        RowLayout {
            Layout.fillHeight: true
            spacing: 30

            Column {
                Layout.fillHeight: true
                spacing: 10

                Text {
                    text: "From:"
                    font.bold: true
                }

                DatePicker {
                    id: fromDatePicker
                    selectedDate: new Date(2026, 0, 1)
                    dateRange: {
                        begin: new Date(2020, 0, 1),
                        end: new Date(2030, 11, 31)
                    }
                }
            }

            Column {
                Layout.fillHeight: true
                spacing: 10

                Text {
                    text: "To:"
                    font.bold: true
                }

                DatePicker {
                    id: toDatePicker
                    selectedDate: new Date(2026, 11, 31)
                    dateRange: {
                        begin: new Date(2020, 0, 1),
                        end: new Date(2030, 11, 31)
                    }
                }
            }
        }

        Row {
            spacing: 20

            Button {
                text: "Apply"
                onClicked: {
                    console.log("From:", fromDatePicker.selectedDate)
                    console.log("To:", toDatePicker.selectedDate)
                }
            }

            Button {
                text: "Reset"
                onClicked: {
                    fromDatePicker.selectedDate = new Date(2026, 0, 1)
                    toDatePicker.selectedDate = new Date(2026, 11, 31)
                }
            }
        }
    }
}
```

## Tips and Best Practices

### 1. Always Set Valid Date Ranges

```qml
// Good: begin < end
dateRange: {
    begin: new Date(2020, 0, 1),
    end: new Date(2030, 11, 31)
}

// Bad: begin > end (will be rejected)
dateRange: {
    begin: new Date(2030, 11, 31),
    end: new Date(2020, 0, 1)
}
```

### 2. Ensure Selected Date is Within Range

```qml
DatePicker {
    selectedDate: new Date(2026, 5, 15)
    dateRange: {
        begin: new Date(2020, 0, 1),
        end: new Date(2030, 11, 31)
    }
    // selectedDate is within range ✓
}
```

### 3. Use Proper Date Construction

```qml
// Correct: months are 0-indexed
var date = new Date(2026, 5, 15)  // June 15, 2026

// Remember: month 0 = January, month 11 = December
```

### 4. Handle Signal Connections Properly

```qml
DatePicker {
    onActivated: (selected) => {
        console.log("Date selected:", selected)
        // Update UI or perform actions
    }
}
```

### 5. Respect Locale Settings

```qml
// Use system locale
datePicker.locale: Qt.locale()

// Or specify custom locale
datePicker.locale: Qt.locale("fr_FR")
```
