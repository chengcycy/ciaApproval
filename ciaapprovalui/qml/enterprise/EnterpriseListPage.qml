import QtQuick 2.0
import com.syberos.basewidgets 2.0
Item{
    id: contactEnterprise

    Connections{
        target: orgNavBarManager
        onUpdateOrgList:{
            orgManager.resetModel(id)
        }
    }

    Rectangle {
        id:background_root
        color: "#f7f7f7"
        anchors.fill: parent
    }
    Rectangle{
        id:titileListView
        height:gUtill.dpH2(52*fp)
        width: parent.width
        color:"#f1f1f5"
        anchors.top: parent.top
        anchors.left: parent.left
        EnterpriseListTitleListViewComponent{
            anchors.fill: parent
        }
    }
    Rectangle{
        id:contentListView
        width:parent.width

        color:"transparent"
        anchors.top:titileListView.bottom
        anchors.bottom: parent.bottom
        EnterpriseListContentListViewComponent{
            anchors.fill: parent
        }
    }
}


