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

## Basic SpinningWheel

The simplest way to use the SpinningWheel component:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Simple Spinning Wheel"

    SpinningWheel {
        anchors.centerIn: parent
        model: ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
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
        dateRange: ({
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        })
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

## SpinningWheel with Custom Delegate

Create a custom delegate for rendering items:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Custom Delegate"

    SpinningWheel {
        anchors.centerIn: parent
        model: ["Apple", "Banana", "Cherry", "Date", "Elderberry"]
        
        delegate: Text {
            anchors.centerIn: parent
            text: modelData
            font.pixelSize: 18
            color: "#0066cc"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
```

## SpinningWheel with Emoji Delegate

Use emoji in custom delegates:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Emoji Delegate"

    SpinningWheel {
        anchors.centerIn: parent
        model: ListModel {
            ListElement { emoji: "🍎"; label: "Apple"  }
            ListElement { emoji: "🍌"; label: "Banana" }
            ListElement { emoji: "🍒"; label: "Cherry" }
            ListElement { emoji: "📅"; label: "Date"   }
            ListElement { emoji: "🫐"; label: "Berry"  }
        }
        
        delegate: Row {
            anchors.centerIn: parent
            spacing: 8
            
            Text {
                text: model.emoji
                font.pixelSize: 24
                verticalAlignment: Text.AlignVCenter
            }
            
            Text {
                text: model.label
                font.pixelSize: 16
                color: "#333"
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
```

## SpinningWheel with Custom Background

Add a custom background with gradient:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Custom Background"

    SpinningWheel {
        anchors.centerIn: parent
        model: 10
        
        background: Rectangle {
            color: "#f5f5f5"
            border.color: "#ddd"
            border.width: 1
            radius: 8
            
            // Top gradient fade
            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#ffffff" }
                    GradientStop { position: 1.0; color: "#00ffffff" }
                }
                z: 1
            }
            
            // Bottom gradient fade
            Rectangle {
                anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00ffffff" }
                    GradientStop { position: 1.0; color: "#ffffff" }
                }
                z: 1
            }
        }
    }
}
```

## SpinningWheel with Dark Background

Create a dark theme background:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Dark Background"
    color: "#1a1a1a"

    SpinningWheel {
        anchors.centerIn: parent
        model: ["Dark", "Mode", "Theme", "Example"]
        
        delegate: Text {
            anchors.centerIn: parent
            text: modelData
            font.pixelSize: 18
            color: "#00ffcc"
            font.bold: true
        }
        
        background: Rectangle {
            color: "#1e1e1e"
            border.color: "#333"
            border.width: 1
            radius: 8
            
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
}
```

## SpinningWheel with Custom Highlight

Create a custom highlight component:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Custom Highlight"

    SpinningWheel {
        anchors.centerIn: parent
        model: ["Red", "Green", "Blue", "Yellow", "Purple"]
        
        highlight: Rectangle {
            color: "#e8f4f8"
            border.color: "#00bcd4"
            border.width: 2
            radius: 8
        }
    }
}
```

## SpinningWheel with Neon Highlight

Create a neon-style highlight:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Neon Highlight"
    color: "#0a0a1a"

    SpinningWheel {
        anchors.centerIn: parent
        model: ["Neon", "Glow", "Effect", "Style"]
        
        delegate: Text {
            anchors.centerIn: parent
            text: modelData
            font.pixelSize: 18
            color: "#00ffcc"
            font.bold: true
        }
        
        highlight: Rectangle {
            color: "#1100ffcc"
            border.color: "#00ffcc"
            border.width: 1
            radius: 6
        }
    }
}
```

## SpinningWheel with Retro Highlight

Create a retro-style highlight:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Retro Highlight"
    color: "#fdf5e6"

    SpinningWheel {
        anchors.centerIn: parent
        model: ["Retro", "Vintage", "Classic", "Style"]
        
        delegate: Text {
            anchors.centerIn: parent
            text: modelData
            font.pixelSize: 18
            color: "#3d2b00"
            font.family: "Courier"
            font.bold: true
        }
        
        highlight: Rectangle {
            color: "#a0ffe0b2"
            border.color: "#bf6c00"
            border.width: 2
            radius: 3
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
        range: ({ from: 2020, to: 2030 })
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
        range: ({ from: 0, to: 11 })
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
        range: ({ from: 1, to: 31 })
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
                dateRange: ({
                    begin: new Date(2020, 0, 1),
                    end: new Date(2030, 11, 31)
                })
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
                dateRange: ({
                    begin: new Date(2020, 0, 1),
                    end: new Date(2030, 11, 31)
                })
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
                    datePicker.dateRange = ({
                        begin: new Date(2020, 0, 1),
                        end: new Date(2025, 11, 31)
                    })
                }
            }

            Button {
                text: "2025-2030"
                onClicked: {
                    datePicker.dateRange = ({
                        begin: new Date(2025, 0, 1),
                        end: new Date(2030, 11, 31)
                    })
                }
            }

            Button {
                text: "2020-2030"
                onClicked: {
                    datePicker.dateRange = ({
                        begin: new Date(2020, 0, 1),
                        end: new Date(2030, 11, 31)
                    })
                }
            }
        }

        DatePicker {
            id: datePicker
            selectedDate: new Date(2026, 5, 15)
            dateRange: ({
                begin: new Date(2020, 0, 1),
                end: new Date(2030, 11, 31)
            })
        }
    }
}
```

## DatePicker with Custom Delegate

Customize the appearance of date picker items:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 400
    height: 500
    visible: true
    title: "DatePicker with Custom Delegate"

    DatePicker {
        anchors.centerIn: parent
        
        selectedDate: new Date(2026, 5, 15)
        dateRange: ({
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        })
        
        delegate: Text {
            anchors.centerIn: parent
            text: modelData
            font.pixelSize: 20
            color: "#1a1a1a"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
```

## DatePicker with Custom Background

Add a custom background to the date picker:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 400
    height: 500
    visible: true
    title: "DatePicker with Custom Background"

    DatePicker {
        anchors.centerIn: parent
        
        selectedDate: new Date(2026, 5, 15)
        dateRange: ({
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        })
        
        background: Rectangle {
            color: "#fafafa"
            border.color: "#e0e0e0"
            border.width: 1
            radius: 8
        }
    }
}
```

## DatePicker with Custom Highlight

Customize the highlight component:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 400
    height: 500
    visible: true
    title: "DatePicker with Custom Highlight"

    DatePicker {
        anchors.centerIn: parent
        
        selectedDate: new Date(2026, 5, 15)
        dateRange: ({
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        })
        
        highlight: Rectangle {
            color: "#fff3e0"
            border.color: "#ff9800"
            border.width: 2
            radius: 6
        }
    }
}
```

## DatePicker with Per-Picker Highlights

Use different highlights for year, month, and day pickers:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 400
    height: 500
    visible: true
    title: "DatePicker with Per-Picker Highlights"

    DatePicker {
        anchors.centerIn: parent
        
        selectedDate: new Date(2026, 5, 15)
        dateRange: ({
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        })
        
        highlightYear: Rectangle {
            color: "#e3f2fd"
            border.color: "#1976d2"
            border.width: 2
            radius: 6
        }
        
        highlightMonth: Rectangle {
            color: "#f3e5f5"
            border.color: "#7b1fa2"
            border.width: 2
            radius: 6
        }
        
        highlightDay: Rectangle {
            color: "#e8f5e9"
            border.color: "#388e3c"
            border.width: 2
            radius: 6
        }
    }
}
```

## DatePicker with Styled Delegate and Background

Combine custom delegate and background:

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
        dateRange: ({
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        })
        
        delegate: Text {
            anchors.centerIn: parent
            text: modelData
            font.pixelSize: 18
            color: "#0066cc"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }
        
        background: Rectangle {
            color: "#f0f8ff"
            border.color: "#4da6ff"
            border.width: 1
            radius: 6
        }
        
        highlight: Rectangle {
            color: "#cce5ff"
            border.color: "#0066cc"
            border.width: 2
            radius: 6
        }
    }
}
```

## DatePicker in Dialog

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
                    dateRange: ({
                        begin: new Date(2020, 0, 1),
                        end: new Date(2030, 11, 31)
                    })
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
                    dateRange: ({
                        begin: new Date(2020, 0, 1),
                        end: new Date(2030, 11, 31)
                    })
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

## SpinningWheel with Complex Model

Use a ListModel with multiple properties:

```qml
import QtQuick
import QtQuick.Window
import Gai

Window {
    width: 300
    height: 400
    visible: true
    title: "Complex Model"

    SpinningWheel {
        anchors.centerIn: parent
        model: ListModel {
            ListElement { name: "Item 1"; value: 100; color: "#ff6b6b" }
            ListElement { name: "Item 2"; value: 200; color: "#4ecdc4" }
            ListElement { name: "Item 3"; value: 300; color: "#45b7d1" }
            ListElement { name: "Item 4"; value: 400; color: "#f7b731" }
        }
        
        delegate: Column {
            anchors.centerIn: parent
            spacing: 4
            
            Rectangle {
                width: 40
                height: 40
                radius: 20
                color: model.color
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                text: model.name
                font.pixelSize: 14
                color: "#333"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                text: "Value: " + model.value
                font.pixelSize: 12
                color: "#999"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
```

## Tips and Best Practices

### 1. Always Set Valid Date Ranges

```qml
// Good: begin <= end
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
    dateRange: ({
        begin: new Date(2020, 0, 1),
        end: new Date(2030, 11, 31)
    })
    // selectedDate is within range ✓
    // If selectedDate is outside range, it will be clamped to the nearest valid date
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

### 6. Customize Components Consistently

```qml
// Define theme components once
Component {
    id: customHighlight
    Rectangle {
        color: "#e3f2fd"
        border.color: "#1976d2"
        border.width: 2
        radius: 8
    }
}

// Reuse across multiple pickers
DatePicker {
    highlight: customHighlight
    highlightYear: customHighlight
    highlightMonth: customHighlight
    highlightDay: customHighlight
}
```

### 7. Use Gradients for Professional Backgrounds

```qml
background: Rectangle {
    color: "#ffffff"
    
    Rectangle {
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: parent.height * 0.3
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ffffff" }
            GradientStop { position: 1.0; color: "#00ffffff" }
        }
        z: 1
    }
}
```

### 8. Create Reusable Custom Delegates

```qml
component CustomTextDelegate: Text {
    anchors.centerIn: parent
    text: modelData
    font.pixelSize: 18
    color: "#0066cc"
    font.bold: true
    horizontalAlignment: Text.AlignHCenter
}

// Use in multiple places
SpinningWheel {
    delegate: CustomTextDelegate {}
}
```
