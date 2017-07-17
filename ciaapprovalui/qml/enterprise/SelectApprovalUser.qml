import QtQuick 2.0
import com.syberos.basewidgets 2.0
CPage{
    id:root
    
    signal callback(var json)

    onStatusChanged: {
        if (status === CPageStatus.WillShow) {
            root.statusBarHoldEnabled = true
            gScreenInfo.setStatusBar(root.statusBarHoldEnabled)
            root.statusBarHoldItemColor = "#394871"
            gScreenInfo.setStatusBarStyle("transwhite")
            orgNavBarManager.test();
        }
    }
    contentAreaItem:Item{
        anchors.fill: parent
        Rectangle{
            id: titleBackground
            width:parent.width
            height:gUtill.dpH2(120*fp)
            color: "#394871"
            
            anchors.top: parent.top
            
            Image{
                id:btnBack
                height: gUtill.dpH(20*fp)
                width: gUtill.dpW(13*fp)
                source:"qrc:/res/ic_back@2x.png"
                anchors.left: parent.left
                anchors.leftMargin: gUtill.dpW2(17)
                anchors.top: parent.top
                anchors.topMargin: gUtill.dpH2(30)
                MouseArea{
                    width:gUtill.dpW2(100*fp)
                    height: gUtill.dpH2(50*fp)
                    anchors.top: parent.top
                    anchors.left: parent.left
                    onClicked: {
                        orgNavBarManager.clear();
                        orgManager.clear();
                        pageStack.pop();
                    }
                }
            }
            Text{
                text:qsTr("选择成员")
                color:"white"
                font.pixelSize: gUtill.dpH(15*fp)
                anchors.centerIn: parent
            }
            Rectangle{
                id:surbutton
                
                color: "transparent"
                anchors.right:parent.right
                anchors.rightMargin: 5
                height: gUtill.dpH2(60*fp)
                width: gUtill.dpW2(200*fp)
                anchors.verticalCenter: parent.verticalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        emit: callback({id:orgManager.id,name:orgManager.name});
                        orgNavBarManager.clear();
                        orgManager.clear();
                        pageStack.pop();
                    }
                }
                Text{
                    text:qsTr("确定")
                    color:"white"
                    font.pixelSize: gUtill.dpH(15*fp)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: gUtill.dpW2(30)
                }
                
            }
        }
        EnterpriseListPage{
            id:org
            width:parent.width
            
            anchors.top: titleBackground.bottom
            anchors.bottom: parent.bottom
        }
    }
}
