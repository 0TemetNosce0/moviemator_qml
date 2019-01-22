
import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import MovieMator.Controls 1.0

Rectangle {
    id: root
    // width:400
    // // width:parent
    // height:400
    property int repeaterItemWidth: 140
    property int repeaterItemHeight: 108

    property var filtersInfoList: []

    function initMetadatamodel(){

    }

    function findFilterModel(name){
        for(var i=0;i<filtersInfoList.length;i++){
            if(name == filtersInfoList[i].name){
                return filtersInfoList[i]
            }
        }
        return null
    }

    // function findAttachedFilterModel(name){
    //     for(var i=0;i<attachedfiltersmodel.rowCount();i++){
    //         if(name == attachedfiltersmodel.getMetadata(i).name){
    //             return i
    //         }
    //     }
    //     return -1
    // }

    function findFilterType(type){
        for(var i=0;i<catListAll.count;i++){
            if(type == catListAll.get(i).typename){
                return catListAll.get(i)
            }
        }
        return null
    }

    Component.onCompleted: {

        console.log("onCompletedonCompletedonCompleted--0: ")

        var num = filtersInfo.rowCount();
        for(var i=0;i< filtersInfo.rowCount();i++){
            var filterInfo = {
                name : filtersInfo.get(i).name,
                filterType : filtersInfo.get(i).filterType,
                imageSourcePath : filtersInfo.get(i).imageSourcePath,
            }
            filtersInfoList.push(filterInfo)
        }
        console.log("onCompletedonCompletedonCompleted-1: ")

        // for(var i=0;i<50;i++){
            
        //     console.log("iiiiiiiiiiiiiiii: " + i)
            
        //     var filterInfo = {
        //         name : "A",
        //         filterType : "B",
        //         imageSourcePath : "C"
        //     }
        //     filtersInfoList.push(filterInfo)
        // }

        for(var j=0;j<filtersInfoList.length;j++){
            console.log(j+"name: " + filtersInfoList[j].name)
            console.log(j+"filterType: " + filtersInfoList[j].filterType)
            console.log(j+"imageSourcePath: " + filtersInfoList[j].imageSourcePath)
        }
        
        catList.clear()
        catListAll.clear()
        catListAll.append({"typename":"全部"})
        for(var i=0;i<filtersInfoList.length;i++){
            
            console.log("filterTypeStrfilterTypeStr: " +i+":"+ filtersInfoList[i].filterType)
            
            if(null == findFilterType(filtersInfoList[i].filterType)){
                catList.append({"typename":filtersInfoList[i].filterType})
                catListAll.append({"typename":filtersInfoList[i].filterType})
            }
        }

        console.log("catList: " + catList.count)
        console.log("catListAll: " + catListAll.count)
    }

    ListModel{
        id:catList
        ListElement{
            typename:'A'
        }
    }
    ListModel{
        id:catListAll
        ListElement{
            typename:'全部'
        }
    }

    Component{ //代理
        id:delegate
        Rectangle{
            id:delegateRoot
            width: scrollView.width-100
            height: Math.ceil(filters.count / parseInt(width / repeaterItemWidth)) * repeaterItemHeight + filterhead.height + 30
            // width:300
            // height:300
            anchors{
                left:parent.left
                leftMargin:50
            }
            color: '#323232'
            function refreshFilters(){
                console.log("typename:"+typename)
                filters.clear()
                for(var i=0;i<filtersInfoList.length;i++){
                    if(typename === filtersInfoList[i].filterType){
                        filters.append(filtersInfoList[i])
                        console.log("name: " + filtersInfoList[i].name)
                    }
                }
            }
            Component.onCompleted: {
                refreshFilters()
            }
            Rectangle{
                id:filterhead
                width: parent.width
                height: 15
                color: '#333333'
                Text {
                    width: 30
                    height: parent.height
                    id: catName
                    text: typename
                    color: '#ffffff'
                    font.pixelSize: 9
                    anchors{
                        left: parent.left
                        leftMargin: -10
                    }
                }
                Image {
                    id: line
                    source: "line.png"
                    anchors{
                        left: catName.right
                        bottom: catName.bottom
                    }
                }

            }
            Flow {
                id:itemFlow
                width: parent.width
                anchors{
                    top:filterhead.bottom
                }
                Repeater{
                    id:rep
                    model: ListModel{
                        id:filters
                    }

                    Rectangle{
                        width: repeaterItemWidth
                        height: repeaterItemHeight
                        color: '#323223'

                        Rectangle{
                            width: 120
                            height: 90
                            color: '#787878'
                            Image {
                                id: myIcon
                                anchors.horizontalCenter : parent.horizontalCenter
                                width: 114
                                height: 70
                                source: 'j20.jpg'
                                anchors {
                                    top: parent.top
                                    topMargin: 3
                                }
                            }
                            Text {
                                height: 20
                                anchors {
                                    top: myIcon.bottom
                                    topMargin: 3
                                    left: myIcon.left
                                    leftMargin: 5
                                    horizontalCenter: parent.horizontalLeft
                                }
                                text: name
                                color: '#ffffff'
                                font.pixelSize: 9
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    parent.color='red'
                                    var mod = findFilterModel(name)
                                    attachedfiltersmodel.add(mod)

                                }
                            }
                        }
                    }

                }
            }
        }
    }

    Rectangle{ //头部
        id: filterHead
        width: parent.width
        height: 30
        z:3
        color: '#000000'
        Label{
            id: tabName
            width: 50
            height: parent.height
            anchors{
                horizontalCenter : parent.horizontalCenter
                verticalCenter : parent.verticalCenter
                top:parent.top
                topMargin: 7
            }
            text: '滤镜'
            font.pixelSize: 12
            color: '#ffffff'
        }

        FilterComboBox {
            id:catCombox
            anchors{
                bottom: parent.bottom
                bottomMargin: 6
                right: parent.right
                rightMargin: 53
            }
            Component.onCompleted: {
                catCombox.setModel(catListAll)
            }
            onCatChanged:{
                if(index <= 0){
                    catList.clear()
                    for(var i=1;i<catListAll.count;i++){
                        catList.append(catListAll.get(i))
                    }
                }else{
                    var chosed = catListAll.get(index)
                    catList.clear()
                    catList.append(chosed)
                }
            }
        }
    }

    ScrollView{
        id: scrollView
        width: parent.width
        height: parent.height - filterHead.height
        anchors.top: filterHead.bottom
        style: ScrollViewStyle {
            transientScrollBars: false
            //  scrollToClickedPosition:true
            handle: Item {
                implicitWidth: 14
                implicitHeight: 14
                Rectangle {
                    color: "#787878"
                    anchors.fill: parent
                    anchors.margins: 3
                    radius: 4
                }
            }
            frame: Item {
                implicitWidth: 14
                implicitHeight: 14
                Rectangle {
                    color: "#323223"
                    anchors.fill: parent
                }
            }
            scrollBarBackground: Item {
                implicitWidth: 14
                implicitHeight: 14
            }
            decrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 0
            }
            incrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 0
            }

        }
        ListView{ //视图
            width:parent.width;
            height:parent.height
            model:catList //关联数据模型
            delegate:delegate //关联代理
            focus:true //可以获得焦点，这样就可以响应键盘了
        }
    }
}
