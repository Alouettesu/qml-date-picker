# QML Date Picker Demo

A demonstration project showcasing a mobile-style date picker component in QML with scrollable year, month, and day selectors.

## Overview

This project implements a reusable date picker component (`DatePicker`) with individual picker components for year, month, and day selection. The component features smooth scrolling interactions similar to those found on mobile platforms (iOS, Android).

## Features

- **DatePicker Component**: Main date picker with year, month, and day selection
- **YearPicker**: Scrollable year selector with configurable range
- **MonthPicker**: Scrollable month selector with range constraints
- **DayPicker**: Scrollable day selector with automatic adjustment for month length
- **Locale Support**: Respects system locale for month names
- **Date Range Validation**: Ensures selected dates fall within specified ranges
- **Smooth Animations**: Fluid scrolling and selection animations

## Project Structure

```
DatePickerDemo/
├── qml/
│   └── main.qml              # Demo application UI
├── src/
│   └── main.cpp              # Application entry point
├── imports/
│   └── Gai/
│       ├── DatePicker.qml    # Main date picker component
│       ├── YearPicker.qml    # Year selection component
│       ├── MonthPicker.qml   # Month selection component
│       ├── DayPicker.qml     # Day selection component
│       ├── qmldir            # QML module definition
│       └── CMakeLists.txt    # Build configuration
├── CMakeLists.txt            # Project build configuration
├── DatePickerDemo.qmlproject # Qt Creator project file
├── qtquickcontrols2.conf     # Qt Quick Controls configuration
└── resources.qrc             # Resource file
```

## Requirements

- Qt 6.x (Core, Gui, Quick, Qml modules)
- CMake 3.16 or higher
- C++17 compatible compiler

## Building

### Option 1: Preview using Qt Designer Studio

1. Open `DatePickerDemo.qmlproject` in Qt Designer Studio
2. Preview the components directly in the designer
3. Push "Run App" button

### Option 2: Command Line Build to Executable

```bash
# Create build directory
mkdir build
cd build

# Configure with CMake
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x

# Build the project
cmake --build .

# Run the application
./DatePickerDebug
```

Replace `/path/to/Qt/6.x` with your actual Qt installation path.

## Usage

### Basic Example

```qml
import QtQuick
import Gai

Window {
    width: 400
    height: 500
    visible: true

    DatePicker {
        id: datePicker
        anchors.centerIn: parent
        
        selectedDate: new Date(2026, 5, 15)
        dateRange: {
            begin: new Date(2020, 0, 1),
            end: new Date(2030, 11, 31)
        }
        
        onActivated: (selected) => {
            console.log("Selected date:", selected)
        }
    }
}
```

### Component Properties

#### DatePicker

- `selectedDate: date` - Currently selected date
- `dateRange: object` - Date range with `begin` and `end` properties
- `locale: Locale` - Locale for month names (defaults to system locale)
- `font: font` - Font for text rendering

#### YearPicker

- `currentYear: int` - Currently selected year
- `range: object` - Year range with `from` and `to` properties

#### MonthPicker

- `currentMonth: int` - Currently selected month (0-11)
- `range: object` - Month range with `from` and `to` properties

#### DayPicker

- `currentDay: int` - Currently selected day
- `range: object` - Day range with `from` and `to` properties

## Demo Application

The included demo application (`qml/main.qml`) demonstrates:

- Multiple date picker instances with different configurations
- Dynamic date range changes
- Month and day picker components
- Interactive testing of various scenarios

Run the application to explore all features.

## License

This project is provided as-is for educational and demonstration purposes.

## Notes

- Created as a demonstration of QML component development with Qt 6.
- The date picker automatically validates date ranges and adjusts invalid selections
- Month and day ranges are constrained to valid values (0-11 for months, 1-31 for days)
- The component respects locale settings for month name display
