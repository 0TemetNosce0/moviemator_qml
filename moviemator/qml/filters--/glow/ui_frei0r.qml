
import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import MovieMator.Controls 1.0

Item {
    property string paramBlur: '0'
    property var defaultParameters: [paramBlur]
    width: 300
    height: 250
    Component.onCompleted: {
        filter.set('start', 1)
        if (filter.isNew) {
            // Set default parameter values
            filter.set(paramBlur, 50.0 / 100.0)
            filter.savePreset(defaultParameters)
            bslider.value = filter.getDouble(paramBlur) * 100.0
        }

        var keyFrameCount = filter.getKeyFrameCountOnProject("anim-0");
        var index=0
        for(index=0; index<keyFrameCount;index++)
        {
            var nFrame = filter.getKeyFrameOnProjectOnIndex(index, "anim-0");
            var keyValue = filter.getKeyValueOnProjectOnIndex(index, "anim-0");
            filter.setKeyFrameParaValue(nFrame, "0", keyValue)
        }
        filter.combineAllKeyFramePara();
    }

    function setKeyFrameValue(bKeyFrame)
    {
        var nFrame = keyFrame.getCurrentFrame();
        if(bKeyFrame)
        {

            filter.setKeyFrameParaValue(nFrame, paramBlur, (bslider.value/100).toString())
            filter.combineAllKeyFramePara();
        }
        else
        {
            //Todo, delete the keyframe date of the currentframe
            filter.removeKeyFrameParaValue(nFrame);
            filter.set(paramBlur, bslider.value/100);

        }
    }
    GridLayout {
        columns: 3
        anchors.fill: parent
        anchors.margins: 8

        KeyFrame{
             id: keyFrame
             Layout.columnSpan:3
        // 	currentPosition: filterDock.getCurrentPosition()
             onSetAsKeyFrame:
             {
                setKeyFrameValue(bKeyFrame)
             }

             onLoadKeyFrame:
             {
                 var glowValue = filter.getKeyFrameParaDoubleValue(keyFrameNum, paramBlur);
                 if(glowValue != -1.0)
                 {
                     bslider.value = glowValue * 100.0

                 }

             }
         }

        Label {
            text: qsTr('Preset')
            Layout.alignment: Qt.AlignRight
            color: '#ffffff'
        }
        Preset {
            Layout.columnSpan: 2
            parameters: defaultParameters
            onPresetSelected: {
                bslider.value = filter.getDouble(paramBlur) * 100.0
            }
        }

        Label {
            text: qsTr('Blur')
            Layout.alignment: Qt.AlignRight
            color: '#ffffff'
        }
        SliderSpinner {
            id: bslider
            minimumValue: 0
            maximumValue: 100
            suffix: ' %'
            value: filter.getDouble(paramBlur) * 100.0
            onValueChanged: {
                if(keyFrame.bKeyFrame)
                {
                    var nFrame = keyFrame.getCurrentFrame();
                    filter.setKeyFrameParaValue(nFrame, paramBlur, (value/100).toString())
                    filter.combineAllKeyFramePara()
                }
                else
                    filter.set(paramBlur, value / 100.0)

            }
        }
        UndoButton {
            onClicked: bslider.value = 50
        }

        Item {
            Layout.fillHeight: true
        }
    }
}