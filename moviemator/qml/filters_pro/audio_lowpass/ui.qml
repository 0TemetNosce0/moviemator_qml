
import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import MovieMator.Controls 1.0

Item {
    width: 300
    height: 250
    Component.onCompleted: {
        if (filter.isNew) {
            // Set default parameter values
            filter.set('0', 2637)
            filter.set('1', 1)
            filter.set('wetness', 1.0)
            filter.savePreset(preset.parameters)
        }
        setControls()
    }

    function setControls() {
        sliderCutoff.value = filter.getDouble('0')
        sliderStages.value = filter.get('1')
        sliderWetness.value = filter.getDouble('wetness') * sliderWetness.maximumValue

    }

    GridLayout {
        anchors.fill: parent
        anchors.margins: 8
        columns: 3


        Label {
            text: qsTr('Preset')
            Layout.alignment: Qt.AlignRight
            color: '#ffffff'
        }
        Preset {
            id: preset
            parameters: ['0', '1', '2', 'wetness']
            Layout.columnSpan: 2
            onPresetSelected: setControls()
        }

        Label {
            text: qsTr('Cutoff frequency')
            Layout.alignment: Qt.AlignRight
            color: '#ffffff'
        }

        SliderSpinner {
            id: sliderCutoff
            minimumValue: 5
            maximumValue: 21600
            suffix: ' Hz'
            spinnerWidth: 80
            value: filter.getDouble('0')
            onValueChanged: {
                filter.set('0', value)
            }
        }
        UndoButton {
                onClicked: sliderCutoff.value = 2637
            }

        Label {
            text: qsTr('Rolloff rate')
            Layout.alignment: Qt.AlignRight
            color: '#ffffff'
        }
        SliderSpinner {
            id: sliderStages
            minimumValue: 1
            maximumValue: 10
            spinnerWidth: 80
            value: filter.get('1')
            onValueChanged: {
                filter.set('1', value)
            }
        }
        UndoButton {
                onClicked: sliderStages.value = 1
            }

        Label {
            text: qsTr('Dry')
            Layout.alignment: Qt.AlignRight
            color: '#ffffff'
        }
        SliderSpinner {
            id: sliderWetness
            minimumValue: 0
            maximumValue: 100
            decimals: 1
            spinnerWidth: 80
            label: qsTr('Wet')
            suffix: ' %'
            value: filter.getDouble('wetness') * maximumValue
            onValueChanged: {
                filter.set('wetness', value / maximumValue)
            }
        }
        UndoButton {
            onClicked: sliderWetness.value = sliderWetness.maximumValue
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
