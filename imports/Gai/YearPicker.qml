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

    readonly property int itemHeight: fontMetrics.height + 8
    readonly property int itemsVisible: height / itemHeight

    property bool _initialized: false
    property bool _modelChanging: false
    property bool _userChanging: false
    property var _lastValidRange: ({ from: 1970, to: 2035 })

    signal activated(int year)

    function _clamp(value) {
        return Math.max(fromYear, Math.min(toYear, value))
    }

    function _scheduleSync() {
        Qt.callLater(_doSync)
    }

    function _doSync() {
        _modelChanging = true
        let target = _clamp(currentYear)
        if (currentYear !== target)
            currentYear = target
        listView.currentIndex = target - fromYear
        listView.positionViewAtIndex(listView.currentIndex, ListView.Center)
        _modelChanging = false
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
        _modelChanging = true
        listView.model = r.to - r.from + 1
        _modelChanging = false
        _scheduleSync()
    }

    function _setByUser(index) {
        _modelChanging = true
        _userChanging = true
        listView.currentIndex = index
        currentYear = fromYear + index
        _modelChanging = false
        _userChanging = false
    }

    Component.onCompleted: {
        _initialized = true
        _applyRange(range)
    }

    onCurrentYearChanged: {
        if (!_initialized || _modelChanging) return
        if (_userChanging)
            activated(currentYear)
        else
            _scheduleSync()
    }

    onRangeChanged: {
        if (!_initialized) return
        _applyRange(range)
    }

    FontMetrics {
        id: fontMetrics
        font: root.font
    }

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        orientation: ListView.Vertical
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        boundsBehavior: Flickable.StopAtBounds
        preferredHighlightBegin: height / 2 - root.itemHeight / 2
        preferredHighlightEnd:   height / 2 + root.itemHeight / 2

        onCurrentIndexChanged: {
            if (!root._initialized || root._modelChanging) return
            root._userChanging = true
            root.currentYear = root.fromYear + currentIndex
            root._userChanging = false
        }

        delegate: Item {
            width: ListView.view.width
            height: root.itemHeight

            Text {
                anchors.centerIn: parent
                text: root.fromYear + index
                font: root.font

                readonly property real distance: Math.abs(index - (root.currentYear - root.fromYear))
                readonly property real t: Math.max(0, 1 - distance / (root.itemsVisible / 2))

                opacity: 0.2 + 0.8 * t
                scale: 0.6 + 0.4 * t
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root._setByUser(index)
                }
                onWheel: (event) => {
                    if (event.angleDelta.y > 0) {
                        listView.decrementCurrentIndex()
                    }
                    else {
                        listView.incrementCurrentIndex()
                    }
                }
            }
        }

        highlight: Rectangle {
            width: listView.width
            height: root.itemHeight
            y: listView.preferredHighlightBegin
            color: "transparent"
            border.color: "#409eff"
            radius: 6
        }
    }
}
