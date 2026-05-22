import QtQuick
import QtQuick.Controls

Item {
    id: root
    implicitWidth: fontMetrics.advanceWidth("0000") * 2
    implicitHeight: 250

    onFontChanged: implicitWidth = fontMetrics.advanceWidth("0000") * 2

    property int currentYear: 2022
    property var range: ({ from: 1970, to: 2035 })
    readonly property int fromYear: range.from
    readonly property int toYear: range.to
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
    property var _lastValidRange: ({ from: 1970, to: 2035 })

    signal activated(int year)

    function _clamp(value) {
        return Math.max(fromYear, Math.min(toYear, value))
    }

    function _validateRange(r) {
        if (r === null || r === undefined) {
            console.warn("YearPicker: range is null/undefined, discarding")
            return false
        }
        if (typeof r !== "object") {
            console.warn("YearPicker: range is not an object, discarding")
            return false
        }
        if (!r.hasOwnProperty("from") || !r.hasOwnProperty("to")) {
            console.warn("YearPicker: range must have 'from' and 'to' properties, discarding")
            return false
        }
        if (typeof r.from !== "number" || typeof r.to !== "number") {
            console.warn("YearPicker: range.from and range.to must be numbers, discarding")
            return false
        }
        if (!Number.isInteger(r.from) || !Number.isInteger(r.to)) {
            console.warn("YearPicker: range.from and range.to must be integers, discarding")
            return false
        }
        if (r.from > r.to) {
            console.warn("YearPicker: range.from (" + r.from + ") > range.to (" + r.to + "), discarding")
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
        let years = []
        for (let y = r.from; y <= r.to; y++)
            years.push(y)
        wheel.model = years
        let target = _clamp(currentYear)
        _modelChanging = true
        if (currentYear !== target)
            currentYear = target
        wheel.currentIndex = target - r.from
        _modelChanging = false
    }

    Component.onCompleted: {
        _initialized = true
        _applyRange(range)
    }

    onCurrentYearChanged: {
        if (!_initialized || _modelChanging) return
        if (_userChanging) {
            activated(currentYear)
        } else {
            let target = _clamp(currentYear)
            _modelChanging = true
            if (currentYear !== target)
                currentYear = target
            wheel.currentIndex = target - fromYear
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
            root.currentYear = root.fromYear + index
            root._userChanging = false
        }
    }
}
