import QtQuick 2.0
import com.moviemator.qml 1.0

Metadata {
    type: Metadata.Filter
    name: qsTr("Sepia Tone")
    mlt_service: "sepia"
    qml: 'ui.qml'
    isFavorite: true
    allowMultiple: false
    filterType: qsTr('Effect')
    keyframes {
        allowAnimateIn: true
        allowAnimateOut: true
        simpleProperties: ['u','v']
        parameters: [
            Parameter {
                name: qsTr('u')
                property: 'u'
                objectName: 'sliderBlue'
                controlType: 'SliderSpinner'
                paraType: 'double'
                defaultValue: '0.008'
                value: '0'
                factorFunc:  []
            },
            Parameter {
                name: qsTr('v')
                property: 'v'
                objectName: 'sliderRed'
                controlType: 'SliderSpinner'
                paraType: 'double'
                defaultValue: '0.016'
                value: '0'
                factorFunc:  []
            }
        ]
    }
}