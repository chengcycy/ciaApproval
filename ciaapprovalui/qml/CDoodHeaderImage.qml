import QtQuick 2.0
import com.syberos.basewidgets 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias bkRect: roundImage
    property url iconSource: ""
    property string name: "storeapp"
    property string type: ""
    property int radius: gUtill.dpW(8*fp)
    height: gUtill.dpH(40*fp)
    width:gUtill.dpW(40*fp)
    function setIcon(type,source){
        root.type = type;
        if(source !==""){
            var tmp = source+"";
            tmp = tmp.substring(0,3);
            if(tmp === "qrc"){
                return source;
            }else{
                roundImage.visible = true;
                return "file://"+source;
            }
        }else if(type === "-5"){
            return "qrc:/res/verf_box.png";
        }
        else if(type === "1")
            return "qrc:/res/moren_icon.png";
        else if(type === "2")
            return "qrc:/res/group_icon.png";
        else if(type === "3")
            return "qrc:/res/Robot.png";
        else if(type === "6")
            return "qrc:/res/icon_pc.png";
        else
            return "qrc:/res/moren_icon.png";
    }

    //    Rectangle{
    //                   width: roundImage.width
    //                   height: roundImage.height
    //                   radius: root.radius
    //                   visible: false

    Item{
        id: roundImage
        anchors.fill: parent
        //source: "qrc:/res/control/bg_photo.png"
        OpacityMask {
            id: bd
            anchors.fill: parent
            source: src.status === Image.Ready ? src : null
            maskSource:  Rectangle{
                width:root.width
                height:root.height
                radius: root.radius
                visible: false
            }
            //            maskSource:  Image{
            //                source: "qrc:/res/control/bg_photo.png"
            //                sourceSize: Qt.size(root.width,root.height)
            //                visible: false
            //            }
        }

        Image {
            id: src
            anchors.fill: parent
            visible: false

            sourceSize: Qt.size(src.width,src.height)
            asynchronous: true
            cache: true
            source:iconSource

            onStatusChanged: {
                if (src.status === Image.Error || src.status === Image.Null) {
                    roundImage.visible = false
                    src.source = setIcon(root.type,"");
                } else if (src.status === Image.Ready) {
                    roundImage.visible = true
                }
            }
        }
    }
}
