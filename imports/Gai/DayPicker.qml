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

    readonly property int itemHeight: fontMetrics.height + 8
    readonly property int itemsVisible: height / itemHeight

    property bool _initialized: false
    property bool _modelChanging: false
    property bool _userChanging: false
    property var _lastValidRange: ({ from: 1, to: 31 })

    signal activated(int day)

    function _clamp(value) {
        return Math.max(fromDay, Math.min(toDay, value))
    }

    function _scheduleSync() {
        Qt.callLater(_doSync)
    }

    function _doSync() {
        _modelChanging = true
        let target = _clamp(currentDay)
        if (currentDay !== target)
            currentDay = target
        listView.currentIndex = target - fromDay
        listView.positionViewAtIndex(listView.currentIndex, ListView.Center)
        _modelChanging = false
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
        _modelChanging = true
        listView.model = r.to - r.from + 1
        _modelChanging = false
        _scheduleSync()
    }

    function _setByUser(index) {
        _modelChanging = true
        _userChanging = true
        listView.currentIndex = index
        currentDay = fromDay + index
        _modelChanging = false
        _userChanging = false
    }

    Component.onCompleted: {
        _initialized = true
        _applyRange(range)
    }

    onCurrentDayChanged: {
        if (!_initialized || _modelChanging) return
        if (_userChanging)
            activated(currentDay)
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
            root.currentDay = root.fromDay + currentIndex
            root._userChanging = false
        }

        delegate: Item {
            width: ListView.view.width
            height: root.itemHeight

            Text {
                anchors.centerIn: parent
                text: root.fromDay + index
                font: root.font

                readonly property real distance: Math.abs(index - (root.currentDay - root.fromDay))
                readonly property real t: Math.max(0, 1 - distance / (root.itemsVisible / 2))

                opacity: 0.2 + 0.8 * t
                scale: 0.6 + 0.4 * t
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root._setByUser(index)
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
