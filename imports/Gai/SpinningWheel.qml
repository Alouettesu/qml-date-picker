import QtQuick
import QtQuick.Controls

Item {
    id: root

    implicitWidth: 100
    implicitHeight: 250

    property var model
    property font font
    property var locale: Qt.locale()
    property int currentIndex: 0

    property Component delegate: Text {
        anchors.centerIn: parent
        text: modelData !== undefined ? modelData
            : (model !== null && typeof model === "object" && model.text !== undefined
                ? model.text : "")
        font: root.font
        horizontalAlignment: Text.AlignHCenter
        color: "#000000"
    }

    property Component highlight: null

    Component {
        id: defaultHighlightComponent
        Rectangle {
            color: "transparent"
            border.color: "#409eff"
            border.width: 1
            radius: 6
        }
    }

    property Component background: Item {}

    readonly property int itemHeight: fontMetrics.height + 8
    readonly property int itemsVisible: height / itemHeight

    property bool _initialized: false
    property bool _modelChanging: false
    property bool _userChanging: false

    signal activated(int index)

    function _scheduleSync() {
        Qt.callLater(_doSync)
    }

    function _doSync() {
        _modelChanging = true
        let clamped = Math.max(0, Math.min(currentIndex, listView.count - 1))
        if (currentIndex !== clamped)
            currentIndex = clamped
        listView.currentIndex = clamped
        listView.positionViewAtIndex(clamped, ListView.Center)
        _modelChanging = false
    }

    function _applyModel(m) {
        _modelChanging = true
        listView.model = m
        _modelChanging = false
        _scheduleSync()
    }

    function _setByUser(index) {
        _userChanging = true
        listView.currentIndex = index
        currentIndex = index
        _userChanging = false
    }

    onCurrentIndexChanged: {
        if (!_initialized || _modelChanging) return
        if (_userChanging)
            activated(currentIndex)
        else
            _scheduleSync()
    }

    onModelChanged: {
        if (!_initialized) return
        _applyModel(model)
    }

    Component.onCompleted: {
        _initialized = true
        _applyModel(model)
    }

    FontMetrics {
        id: fontMetrics
        font: root.font
    }

    Loader {
        anchors.fill: parent
        sourceComponent: root.background
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
        highlightMoveDuration: 0
        highlightResizeDuration: 0

        highlight: Loader {
            width: listView.width
            height: root.itemHeight
            sourceComponent: root.highlight !== null ? root.highlight : defaultHighlightComponent
        }

        onCurrentIndexChanged: {
            if (!root._initialized || root._modelChanging) return
            root._userChanging = true
            root.currentIndex = currentIndex
            root._userChanging = false
        }

        delegate: Item {
            id: delegateItem
            width: ListView.view.width
            height: root.itemHeight

            readonly property int _index: index
            readonly property var _modelData: modelData
            readonly property var _model: model

            readonly property real distance: Math.abs(_index - root.currentIndex)
            readonly property real t: Math.max(0, 1 - distance / (root.itemsVisible / 2))

            opacity: 0.2 + 0.8 * t
            scale: 0.6 + 0.4 * t

            Loader {
                anchors.fill: parent
                sourceComponent: root.delegate
                property int index: delegateItem._index
                property var modelData: delegateItem._modelData
                property var model: delegateItem._model
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root._setByUser(delegateItem._index)
            }
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true

            onClicked: (event) => {
                event.accepted = false
            }
            onWheel: (event) => {
                if (event.angleDelta.y > 0)
                    listView.decrementCurrentIndex()
                else if (event.angleDelta.y < 0)
                    listView.incrementCurrentIndex()
            }
        }
    }
}
