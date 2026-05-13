# Development Guide

## Setting Up Your Development Environment

### Prerequisites

- Qt 6.x with development tools
- CMake 3.16+
- Git
- A C++17 compatible compiler

### Initial Setup

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

3. Configure with CMake:
```bash
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x/gcc_64
```

4. Build the project:
```bash
cmake --build .
```

## Project Structure

```
DatePickerDemo/
├── qml/                          # QML source files
│   └── main.qml                 # Demo application
├── src/                          # C++ source files
│   └── main.cpp                 # Application entry point
├── imports/Gai/                 # QML module
│   ├── DatePicker.qml           # Main date picker component
│   ├── YearPicker.qml           # Year picker component
│   ├── MonthPicker.qml          # Month picker component
│   ├── DayPicker.qml            # Day picker component
│   ├── qmldir                   # Module definition
│   └── CMakeLists.txt           # Module build config
├── CMakeLists.txt               # Project build config
├── DatePickerDemo.qmlproject    # Qt Creator project
├── qtquickcontrols2.conf        # Qt Quick Controls config
└── resources.qrc                # Resource file
```

## Component Architecture

### DatePicker Component

The main component that combines year, month, and day pickers:

- **Properties:**
  - `selectedDate: date` - The currently selected date
  - `dateRange: object` - Valid date range {begin, end}
  - `locale: Locale` - Locale for month names
  - `font: font` - Font for rendering

- **Signals:**
  - `activated(date selected)` - Emitted when date is selected

### Individual Picker Components

Each picker (Year, Month, Day) can be used independently:

- **YearPicker:** Manages year selection within a range
- **MonthPicker:** Manages month selection (0-11) with range constraints
- **DayPicker:** Manages day selection with automatic month length adjustment

## Development Workflow

### Making Changes

1. Create a feature branch:
```bash
git checkout -b feature/your-feature-name
```

2. Make your changes and test thoroughly

3. Commit with clear messages:
```bash
git commit -m "Add feature: description"
```

4. Push to your fork:
```bash
git push origin feature/your-feature-name
```

5. Open a Pull Request on GitHub

### Testing

Before submitting changes:

1. Build the project successfully
2. Run the demo application
3. Test all affected components
4. Verify no regressions in existing functionality

### Code Style

- Follow Qt and QML conventions
- Use 4-space indentation for QML and C++
- Use 2-space indentation for CMake
- Add comments for complex logic
- Use meaningful variable names

## Building for Different Platforms

### Linux

```bash
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH=/opt/Qt/6.x/gcc_64
cmake --build .
./DatePickerDebug
```

### Windows (MSVC)

```bash
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH=C:\Qt\6.x\msvc2019_64
cmake --build . --config Release
Release\DatePickerDebug.exe
```

### macOS

```bash
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH=/Users/username/Qt/6.x/macos
cmake --build .
./DatePickerDebug
```

## Debugging

### Using Qt Designer Studio

1. Open `DatePickerDemo.qmlproject` in Qt Designer Studio
2. Set breakpoints in QML code
3. Run with debugger (F5)

### Using Command Line

```bash
# Build with debug symbols
cmake .. -DCMAKE_BUILD_TYPE=Debug
cmake --build .

# Run with GDB (Linux/macOS)
gdb ./DatePickerDebug

# Run with LLDB (macOS)
lldb ./DatePickerDebug
```

## Common Issues

### CMake Cannot Find Qt

Ensure Qt path is correct:
```bash
cmake .. -DCMAKE_PREFIX_PATH=/correct/path/to/Qt/6.x/compiler
```

### Build Fails with Missing Modules

Install required Qt modules:
- QtCore
- QtGui
- QtQuick
- QtQml

### QML Module Not Found

Ensure `imports/Gai/qmldir` is properly configured and the module is built.

## Performance Considerations

- The date picker uses smooth animations for scrolling
- Date range validation is performed efficiently
- Locale-specific month names are cached

## Getting Help

- Check existing issues and discussions
- Review the README and GETTING_STARTED guide
- Open a new issue with detailed information

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.
