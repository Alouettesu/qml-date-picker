# Architecture Overview

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

## Component Hierarchy

```
DatePicker (Main Component)
├── YearPicker
│   └── ListView (scrollable years)
├── MonthPicker
│   └── ListView (scrollable months)
└── DayPicker
    └── ListView (scrollable days)
```

## Data Flow

### Date Selection Flow

```
User Input (Scroll)
    ↓
Picker Component (YearPicker/MonthPicker/DayPicker)
    ↓
Update currentYear/currentMonth/currentDay
    ↓
DatePicker (synchronization)
    ↓
Validate date range
    ↓
Update selectedDate
    ↓
Emit activated(date) signal
```

### Date Range Validation

```
New dateRange Set
    ↓
Validate (begin < end)
    ↓
If valid:
    - Update internal range
    - Adjust pickers if needed
    - Validate current selection
Else:
    - Keep previous range
    - Log warning
```

## Component Responsibilities

### DatePicker

**Purpose:** Main component that coordinates year, month, and day selection

**Responsibilities:**
- Manage selectedDate property
- Validate and maintain dateRange
- Synchronize between individual pickers
- Handle locale settings
- Emit activated signal

**Key Properties:**
- `selectedDate: date` - Currently selected date
- `dateRange: object` - Valid date range {begin, end}
- `locale: Locale` - Locale for month names
- `font: font` - Font for rendering

**Key Signals:**
- `activated(date selected)` - Emitted when date is selected on user interaction, not on assigning `selectedDate` property
- `selectedDateChanged()` - Emitted when date is selected on both user interaction or assigning `selectedDate` property

### YearPicker

**Purpose:** Handles year selection within a range

**Responsibilities:**
- Display scrollable list of years
- Manage currentYear property
- Validate year range
- Handle scroll interactions

**Key Properties:**
- `currentYear: int` - Currently selected year
- `range: object` - Year range {from, to}

### MonthPicker

**Purpose:** Handles month selection with range constraints

**Responsibilities:**
- Display scrollable list of months
- Manage currentMonth property (0-11)
- Validate month range
- Handle scroll interactions
- Format month names based on locale

**Key Properties:**
- `currentMonth: int` - Currently selected month (0-11)
- `range: object` - Month range {from, to}

### DayPicker

**Purpose:** Handles day selection with automatic month length adjustment

**Responsibilities:**
- Display scrollable list of days
- Manage currentDay property
- Validate day range
- Adjust for month length
- Handle scroll interactions

**Key Properties:**
- `currentDay: int` - Currently selected day
- `range: object` - Day range {from, to}

## State Management

### DatePicker Internal State

```
_initialized: bool
    - Tracks if component is fully initialized
    - Prevents validation during initialization

_userChanging: bool
    - Indicates user is actively scrolling
    - Prevents automatic adjustments during interaction

_syncing: bool
    - Prevents circular updates between pickers
    - Ensures consistent state

_lastValidRange: object
    - Stores last valid date range
    - Used for rollback on invalid range
```

## Synchronization Logic

### When Year Changes

```
YearPicker.currentYear → DatePicker
    ↓
Update selectedDate year
    ↓
Validate day for new month/year
    ↓
Adjust day if needed (e.g., Feb 30 → Feb 28)
    ↓
Update DayPicker range
    ↓
Emit activated signal
```

### When Month Changes

```
MonthPicker.currentMonth → DatePicker
    ↓
Update selectedDate month
    ↓
Validate day for new month
    ↓
Adjust day if needed (e.g., Jan 31 → Feb 28)
    ↓
Update DayPicker range
    ↓
Emit activated signal
```

### When Day Changes

```
DayPicker.currentDay → DatePicker
    ↓
Update selectedDate day
    ↓
Emit activated signal
```

## Date Validation

### Range Validation

```
dateRange = {begin, end}
    ↓
Check: begin < end
    ↓
If valid:
    - Accept range
    - Update pickers
Else:
    - Reject range
    - Keep previous range
    - Log warning
```

### Selection Validation

```
selectedDate = new Date(year, month, day)
    ↓
Check: begin ≤ selectedDate ≤ end
    ↓
If valid:
    - Accept selection
    - Update pickers
Else:
    - Clamp to range
    - Update pickers
    - Emit adjusted date
```

### Day Range Validation

```
For given year and month:
    ↓
Calculate days in month
    ↓
Set DayPicker range: {1, daysInMonth}
    ↓
If currentDay > daysInMonth:
    - Adjust to last day of month
```

## Animation & Interaction

### Scroll Behavior

- Smooth deceleration animation
- Snap to nearest item
- Haptic feedback (platform dependent)
- Momentum scrolling support

### Visual Feedback

- Highlight selected item
- Fade effect for non-selected items
- Smooth transitions between selections

## Performance Considerations

### Optimization Strategies

1. **Lazy Loading:** Pickers only render visible items
2. **Caching:** Month names cached per locale
3. **Efficient Validation:** Range checks use simple comparisons
4. **Minimal Redraws:** Only affected components update

### Memory Usage

- Typical memory footprint: < 5 MB
- Scales well with date range size
- No memory leaks with proper cleanup

## Extension Points

### Customization Options

1. **Styling:** Modify colors, fonts, sizes in QML
2. **Behavior:** Adjust animation speeds, scroll sensitivity
3. **Locale:** Support additional locales
4. **Validation:** Add custom date validation logic

### Integration Points

1. **Signal Connections:** Connect to `activated` signal
2. **Property Binding:** Bind to `selectedDate` property
3. **Custom Ranges:** Set `dateRange` dynamically
4. **Locale Support:** Set `locale` property
