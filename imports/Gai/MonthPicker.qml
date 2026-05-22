import QtQuick
import QtQuick.Controls

Item {
    id: root
    implicitWidth: calcMonthWidth()

    function calcMonthWidth() {
        let local_width = 0
        for (let i = 0; i <= 11; i++) {
            let monthName = root.locale.standaloneMonthName(i, Locale.LongFormat)
            let monthWidth = fontMetrics.advanceWidth(monthName)
            if (monthWidth > local_width)
                local_width = monthWidth
        }
        return local_width * 2
    }

    onFontChanged: {
        implicitWidth = calcMonthWidth()
        if (_initialized) _rebuildModel()
    }
    onLocaleChanged: {
        implicitWidth = calcMonthWidth()
        if (_initialized) _rebuildModel()
    }

    implicitHeight: 250

    property int currentMonth: 0
    property var range: ({ from: 0, to: 11 })
    readonly property int fromMonth: range.from
    readonly property int toMonth: range.to
    property var locale: Qt.locale()
    property font font

    property Component delegate: Text {
        anchors.centerIn: parent
        text: modelData
        font: root.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    }

    property Component highlight: null
    property Component background: null

    Component {
        id: _defaultHighlight
        Rectangle {
            color: "transparent"
            border.color: "#409eff"
            border.width: 1
            radius: 6
        }
    }

    Component {
        id: _defaultBackground
        Item {}
    }

    property bool _initialized: false
    property bool _modelChanging: false
    property bool _userChanging: false
    property var _lastValidRange: ({ from: 0, to: 11 })

    signal activated(int month)

    function _clamp(value) {
        return Math.max(fromMonth, Math.min(toMonth, value))
    }

    function _rebuildModel() {
        let months = []
        for (let i = range.from; i <= range.to; i++)
            months.push(root.locale.standaloneMonthName(i, Locale.LongFormat))
        wheel.model = months
    }

    function _validateRange(r) {
        if (r === null || r === undefined) {
            console.warn("MonthPicker: range is null/undefined, discarding")
            return false
        }
        if (typeof r !== "object") {
            console.warn("MonthPicker: range is not an object, discarding")
            return false
        }
        if (!r.hasOwnProperty("from") || !r.hasOwnProperty("to")) {
            console.warn("MonthPicker: range must have 'from' and 'to' properties, discarding")
            return false
        }
        if (typeof r.from !== "number" || typeof r.to !== "number") {
            console.warn("MonthPicker: range.from and range.to must be numbers, discarding")
            return false
        }
        if (!Number.isInteger(r.from) || !Number.isInteger(r.to)) {
            console.warn("MonthPicker: range.from and range.to must be integers, discarding")
            return false
        }
        if (r.from < 0 || r.to > 11) {
            console.warn("MonthPicker: range must be within [0, 11], discarding")
            return false
        }
        if (r.from > r.to) {
            console.warn("MonthPicker: range.from (" + r.from + ") > range.to (" + r.to + "), discarding")
            return false
        }
        return true
    }

    function _applyRange(r) {
        if (!_validateRange(r)) {
            range = _lastValidRange
            return
        }
        _lastValidRange = r
        _rebuildModel()
        let target = _clamp(currentMonth)
        _modelChanging = true
        if (currentMonth !== target)
            currentMonth = target
        wheel.currentIndex = target - r.from
        _modelChanging = false
    }

    Component.onCompleted: {
        _initialized = true
        _applyRange(range)
    }

    onCurrentMonthChanged: {
        if (!_initialized || _modelChanging) return
        if (_userChanging) {
            activated(currentMonth)
        } else {
            let target = _clamp(currentMonth)
            _modelChanging = true
            if (currentMonth !== target)
                currentMonth = target
            wheel.currentIndex = target - fromMonth
            _modelChanging = false
        }
    }

    onRangeChanged: {
        if (!_initialized) return
        _applyRange(range)
    }

    FontMetrics {
        id: fontMetrics
        font: root.font
    }

    SpinningWheel {
        id: wheel
        anchors.fill: parent
        font: root.font
        locale: root.locale
        delegate: root.delegate
        highlight: root.highlight !== null ? root.highlight : _defaultHighlight
        background: root.background != null ? root.background : _defaultBackground

        onActivated: (index) => {
            root._userChanging = true
            root.currentMonth = root.fromMonth + index
            root._userChanging = false
        }
    }
}
