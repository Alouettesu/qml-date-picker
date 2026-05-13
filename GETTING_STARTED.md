# QML Date Picker Demo - Getting Started

## Quick Start

### Prerequisites

- Qt 6.x installed with development tools
- CMake 3.16 or higher
- A C++17 compatible compiler

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Alouettesu/qml-date-picker.git
cd qml-date-picker-demo
```

2. Create a build directory:
```bash
mkdir build
cd build
```

3. Configure the project:
```bash
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x
```

4. Build:
```bash
cmake --build .
```

5. Run:
```bash
./DatePickerDebug
```

## Opening in Qt Designer Studio

1. Launch Qt Designer Studio
2. Open `DatePickerDemo.qmlproject`
3. Browse and preview the components directly in the designer

## Project Layout

- **qml/** - QML source files and demo application
- **src/** - C++ source files
- **imports/Gai/** - QML module with picker components
- **CMakeLists.txt** - Build configuration

## Key Components

### DatePicker
Main component combining year, month, and day pickers.

```qml
DatePicker {
    selectedDate: new Date(2026, 5, 15)
    dateRange: {
        begin: new Date(2020, 0, 1),
        end: new Date(2030, 11, 31)
    }
}
```

### YearPicker
Standalone year selection component.

```qml
YearPicker {
    currentYear: 2026
    range: { from: 2020, to: 2030 }
}
```

### MonthPicker
Standalone month selection component.

```qml
MonthPicker {
    currentMonth: 5
    range: { from: 0, to: 11 }
}
```

### DayPicker
Standalone day selection component.

```qml
DayPicker {
    currentDay: 15
    range: { from: 1, to: 31 }
}
```

## Troubleshooting

### CMake Configuration Issues

If CMake cannot find Qt:
```bash
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x
```

On Windows with MSVC:
```bash
cmake .. -DCMAKE_PREFIX_PATH=C:\Qt\6.x\msvc2019_64
```

On macOS:
```bash
cmake .. -DCMAKE_PREFIX_PATH=/Users/username/Qt/6.x/macos
```

### Build Errors

Ensure you have:
- Qt 6.x development files installed
- All required Qt modules (Core, Gui, Quick, Qml)
- C++17 support in your compiler

## Next Steps

- Explore the demo application in `qml/main.qml`
- Review component implementations in `imports/Gai/`
- Customize components for your needs
- Integrate into your own Qt projects

## Support

For issues, questions, or suggestions, please open an issue on GitHub.
