qt_add_library(Gai STATIC)

set(RESOURCE_PREFIX "/")

if(DEFINED GAI_RESOURCE_PREFIX)
    set(RESOURCE_PREFIX ${GAI_RESOURCE_PREFIX})
endif()

qt6_add_qml_module(Gai

	URI "Gai"
	RESOURCE_PREFIX ${RESOURCE_PREFIX}

	VERSION 1.0

	QML_FILES

		DatePicker.qml
		DayPicker.qml
		MonthPicker.qml
		SpinningWheel.qml
		YearPicker.qml

)

