import QtQuick
import QtQuick.Controls

Item {
    id: root
    implicitWidth: fontMetrics.advanceWidth("00") * 2
    implicitHeight: 250

    onFontChanged: implicitWidth = fontMetrics.advanceWidth("00") * 2

    property int currentDay: 1
    property var range: ({ from: 1, to: 31 })
    readonly property int fromDay: range.from
    readonly property int toDay: range.to
    property font font
    property var locale: Qt.locale()

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
    property var _lastValidRange: ({ from: 1, to: 31 })

    signal activated(int day)

    function _clamp(value) {
        return Math.max(fromDay, Math.min(toDay, value))
    }

    function _validateRange(r) {
        if (r === null || r === undefined) {
            console.warn("DayPicker: range is null/undefined, discarding")
            return false
        }
        if (typeof r !== "object") {
            console.warn("DayPicker: range is not an object, discarding")
            return false
        }
        if (!r.hasOwnProperty("from") || !r.hasOwnProperty("to")) {
            console.warn("DayPicker: range must have 'from' and 'to' properties, discarding")
            return false
        }
        if (typeof r.from !== "number" || typeof r.to !== "number") {
            console.warn("DayPicker: range.from and range.to must be numbers, discarding")
            return false
        }
        if (!Number.isInteger(r.from) || !Number.isInteger(r.to)) {
            console.warn("DayPicker: range.from and range.to must be integers, discarding")
            return false
        }
        if (r.from < 1 || r.to > 31) {
            console.warn("DayPicker: range must be within [1, 31], discarding")
            return false
        }
        if (r.from > r.to) {
            console.warn("DayPicker: range.from (" + r.from + ") > range.to (" + r.to + "), discarding")
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

        let days = []
        for (let d = r.from; d <= r.to; d++)
            days.push(d)
        wheel.model = days

        let target = _clamp(currentDay)
        _modelChanging = true
        if (currentDay !== target)
            currentDay = target
        wheel.currentIndex = target - r.from
        _modelChanging = false
    }

    Component.onCompleted: {
        _initialized = true
        _applyRange(range)
    }

    onCurrentDayChanged: {
        if (!_initialized || _modelChanging) return
        if (_userChanging) {
            activated(currentDay)
        } else {
            let target = _clamp(currentDay)
            _modelChanging = true
            if (currentDay !== target)
                currentDay = target
            wheel.currentIndex = target - fromDay
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
            root.currentDay = root.fromDay + index
            root._userChanging = false
        }
    }
}
