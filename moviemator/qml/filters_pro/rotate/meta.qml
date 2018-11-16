import QtQuick 2.0
import com.moviemator.qml 1.0

Metadata {
    type: Metadata.Filter
    objectName: "affineRotate"
    name: qsTr("Rotate")
    mlt_service: "affine"
    qml: "ui.qml"
    isFavorite: true
    keyframes {
        allowAnimateIn: true
        allowAnimateOut: true
        simpleProperties: ['transition.fix_rotate_x', 'transition.scale_x','transition.ox','transition.oy']
        minimumVersion: '3'
        parameters: [
            Parameter {
                name: qsTr('Rotation')
                property: 'transition.fix_rotate_x'
                isSimple: true
                isCurve: true
                minimum: -360
                maximum: 360
            },
            Parameter {
                name: qsTr('Scale')
                property: 'transition.scale_x'
              //  gangedProperties: ['transition.scale_y']
                isSimple: true
            },
            Parameter {
                name: qsTr('Scale')
                property: 'transition.scale_y'
              //  gangedProperties: ['transition.scale_y']
                isSimple: true
            },
            Parameter {
                name: qsTr('X offset')
                property: 'transition.ox'
            },
            Parameter {
                name: qsTr('Y offset')
                property: 'transition.oy'
            }
        ]
    }
}
