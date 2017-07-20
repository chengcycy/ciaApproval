import QtQuick 2.0
import com.syberos.basewidgets 2.0
import "../"
Rectangle{
    id:contentListView_root
    color:"transparent"

    anchors.fill: parent
    ListView {
        id: orgListView
        anchors.fill: parent
        clip: true
        model: orgManager
        delegate:Item {
            id:contactListDelegate
            visible: (''+model.modelData.id) !== mainApp.currentID
            width: parent.width
            height: ((''+model.modelData.id) === mainApp.currentID)?0:gUtill.dpH2(100*fp)
            MouseArea {
                anchors.fill: parent

                onPressed: {
                    if(mousePressBackgroud.visible){
                        background.color = "#ffffff"
                        mousePressBackgroud.visible = false
                    }else{
                        background.color = "#dcdcdc"
                        mousePressBackgroud.visible = true
                    }
                }

                onReleased: {
                    background.color = "#ffffff"
                    mousePressBackgroud.visible = false
                    if(model.modelData.isDepart){
                        orgNavBarManager.setNav(model.modelData.id,model.modelData.name);
                    }
                    else{
                        background.color = "#ffffff"
                        mousePressBackgroud.visible = false
                        orgManager.setSel(model.modelData.id);
                    }
                }

                onCanceled: {
                    background.color = "#ffffff"
                    mousePressBackgroud.visible = false
                }
            }

            Rectangle {
                width: contactListDelegate.width
                height: contactListDelegate.height
                color:"#ffffff"


                Rectangle {
                    id : mousePressBackgroud
                    anchors.fill: parent
                    visible: false
                    color: "#dcdcdc"
                }

                Rectangle {
                    id : background
                    anchors.fill: parent
                    color:"#ffffff"

                    CDoodHeaderImage{
                        id: headPortraitImage
                        anchors.left: parent.left
                        anchors.leftMargin: gUtill.dpW2(25*fp)
                        anchors.topMargin: gUtill.dpH2(16*fp)
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource:model.modelData.isDepart?"qrc:/res/Group@2x.png":"qrc:/res/moren_icon.png"
                    }
                    Text {
                        id: nameText
                        anchors.left: headPortraitImage.right
                        anchors.leftMargin: gUtill.dpW2(30*fp)
                        anchors.rightMargin: gUtill.dpW2(20*fp)
                        anchors.right:parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: gUtill.dpH2(30*fp)
                        height: gUtill.dpH2(50*fp)
                        clip: true
                        color: "#545454"
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        text: model.modelData.name
                    }
                    CCheckBox{
                        id:checkBox

                        visible: !model.modelData.isDepart
                        checked: model.modelData.isSel
                        enabled: false
//                        normalColor: "blue"
                        checkedColor: "blue"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: gUtill.dpW2(40)
                    }

                    CLine {
                        width: 1
                        anchors.left: nameText.left
                        color:"#dcdcdc"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        z: parent.z+2
                    }
                }
            }
        }
    }
}
