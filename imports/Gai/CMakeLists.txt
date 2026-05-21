qt_add_library(Gai STATIC)


qt6_add_qml_module(Gai

	URI "Gai"
	RESOURCE_PREFIX /

	VERSION 1.0

	QML_FILES

		DatePicker.qml
		DayPicker.qml
		MonthPicker.qml
		SpinningWheel.qml
		YearPicker.qml

)

