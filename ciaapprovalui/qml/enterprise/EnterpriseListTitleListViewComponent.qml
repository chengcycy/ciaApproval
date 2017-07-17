import QtQuick 2.0
import com.syberos.basewidgets 2.0
Rectangle{
    id:titleListView_root
    color:"transparent"
    anchors.fill: parent
    ListView{
        id: orgTitleListView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin:gUtill.dpW2(47*fp)
        width: parent.width
        height: parent.height
        orientation:ListView.Horizontal
        spacing: gUtill.dpW2(-25*fp)
        model: orgNavBarManager
        snapMode: ListView.SnapOneItem
        Rectangle{
            anchors.fill: parent
            color:"#F2F2F2"
            z:parent.z -1
        }

        delegate: Rectangle{
            width: gUtill.dpW2((name.contentWidth+80)*fp)
            height: gUtill.dpH2(53*fp)
            anchors.top:parent.top
            color:"#F2F2F2"
            anchors.topMargin: 0
            BorderImage{
                width: parent.width
                height: parent.height
                border.left: gUtill.dpW2(25*fp)
                border.right: gUtill.dpW2(25*fp)
                anchors.top:parent.top
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: gUtill.dpW2(-25*fp)
                source: model.modelData.isSel?"qrc:/res/selected.png":"qrc:/res/unselected.png"
                z:parent.z+10
                Text {
                    id: name
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: model.modelData.name
                    font.pixelSize: gUtill.dpH2(26*fp)
                    color:"#333333"
                }

            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    orgNavBarManager.setNav(model.modelData.id,model.modelData.name);
                }
            }
        }
    }
    CLine {
        id:line
        width: parent.width
        color:"#dcdcdc"
        anchors.top: parent.bottom
        anchors.left:parent.left
        z: parent.z+2
        visible: /*enterpriseManager.isOrg?true:false*/true
    }

}
