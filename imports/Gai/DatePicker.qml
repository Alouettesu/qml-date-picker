import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: datePicker

    property date selectedDate: new Date()
    property var dateRange: ({
        begin: new Date(new Date().getFullYear() - 5, 0, 1),
        end:   new Date(new Date().getFullYear() + 5, 11, 31)
    })
    property var locale: Qt.locale()
    property font font

    implicitWidth: yearPicker.implicitWidth + monthPicker.implicitWidth + dayPicker.implicitWidth
    implicitHeight: 320

    property bool _initialized: false
    property bool _userChanging: false
    property bool _syncing: false
    property var _lastValidRange: ({
        begin: new Date(new Date().getFullYear() - 5, 0, 1),
        end:   new Date(new Date().getFullYear() + 5, 11, 31)
    })

    signal activated(date selected)

    function daysInMonth(year, month) {
        return new Date(year, month + 1, 0).getDate()
    }

    function _validateRange(r) {
        if (r === null || r === undefined) {
            console.warn("DatePicker: dateRange is null/undefined, discarding")
            return false
        }
        if (!r.hasOwnProperty("begin") || !r.hasOwnProperty("end")) {
            console.warn("DatePicker: dateRange must have 'begin' and 'end' properties, discarding")
            return false
        }
        if (!(r.begin instanceof Date) || isNaN(r.begin.getTime()) ||
            !(r.end   instanceof Date) || isNaN(r.end.getTime())) {
            console.warn("DatePicker: dateRange.begin and dateRange.end must be valid Dates, discarding")
            return false
        }
        if (r.begin > r.end) {
            console.warn("DatePicker: dateRange.begin > dateRange.end, discarding")
            return false
        }
        return true
    }

    function _clampDate(d) {
        let begin = _lastValidRange.begin
        let end   = _lastValidRange.end
        if (d < begin) return new Date(begin)
        if (d > end)   return new Date(end)
        return d
    }

    function _updatePickerRanges() {
        let r     = _lastValidRange
        let begin = r.begin
        let end   = r.end

        let byear = begin.getFullYear()
        let bmon  = begin.getMonth()
        let bday  = begin.getDate()
        let eyear = end.getFullYear()
        let emon  = end.getMonth()
        let eday  = end.getDate()

        let cy = yearPicker.currentYear
        let cm = monthPicker.currentMonth

        yearPicker.range = { from: byear, to: eyear }

        let mfrom = (cy === byear) ? bmon : 0
        let mto   = (cy === eyear) ? emon : 11
        monthPicker.range = { from: mfrom, to: mto }

        let dim   = daysInMonth(cy, cm)
        let dfrom = (cy === byear && cm === bmon) ? bday : 1
        let dto   = (cy === eyear && cm === emon) ? Math.min(eday, dim) : dim
        dayPicker.range = { from: dfrom, to: dto }
    }

    function _commitFromPickers() {
        let y = yearPicker.currentYear
        let m = monthPicker.currentMonth
        let d = Math.min(dayPicker.currentDay, daysInMonth(y, m))
        let candidate = new Date(y, m, d)
        candidate = _clampDate(candidate)
        _syncing = true
        selectedDate = candidate
        _syncing = false
        if (_userChanging)
            activated(selectedDate)
    }

    function _syncPickersFromDate(d) {
        _syncing = true
        yearPicker.currentYear   = d.getFullYear()
        monthPicker.currentMonth = d.getMonth()
        dayPicker.currentDay     = d.getDate()
        _syncing = false
        _updatePickerRanges()
    }

    Component.onCompleted: {
        _initialized = true
        if (_validateRange(dateRange))
            _lastValidRange = dateRange
        let clamped = _clampDate(selectedDate)
        _syncPickersFromDate(clamped)
        if (clamped.getTime() !== selectedDate.getTime())
            selectedDate = clamped
    }

    onDateRangeChanged: {
        if (!_initialized) return
        if (!_validateRange(dateRange)) {
            dateRange = _lastValidRange
            return
        }
        _lastValidRange = dateRange
        let clamped = _clampDate(selectedDate)
        _syncPickersFromDate(clamped)
        if (clamped.getTime() !== selectedDate.getTime())
            selectedDate = clamped
    }

    onSelectedDateChanged: {
        if (!_initialized || _syncing) return
        let clamped = _clampDate(selectedDate)
        if (clamped.getTime() !== selectedDate.getTime()) {
            selectedDate = clamped
            return
        }
        _syncPickersFromDate(selectedDate)
    }

    Row {
        anchors.fill: parent

        YearPicker {
            id: yearPicker
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font: datePicker.font
            locale: datePicker.locale
            onActivated: {
                datePicker._userChanging = true
                datePicker._updatePickerRanges()
                datePicker._commitFromPickers()
                datePicker._userChanging = false
            }
        }

        MonthPicker {
            id: monthPicker
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font: datePicker.font
            locale: datePicker.locale
            onActivated: {
                datePicker._userChanging = true
                datePicker._updatePickerRanges()
                datePicker._commitFromPickers()
                datePicker._userChanging = false
            }
        }

        DayPicker {
            id: dayPicker
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font: datePicker.font
            locale: datePicker.locale
            onActivated: {
                datePicker._userChanging = true
                datePicker._commitFromPickers()
                datePicker._userChanging = false
            }
        }
    }
}
