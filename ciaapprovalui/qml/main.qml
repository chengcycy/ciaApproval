import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPageStackWindow {
    initialPage:CPage{
        width:parent.width
        height:parent.height
        CButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: approvalBtn.top
            anchors.bottomMargin: 30
            text: '登录接口'
            onClicked: {
                ApprovalRequest.getJSONFile(onGetJSONFile)
                //////////////////////////////////////////////////////
            }
        }
        CButton {
            id: approvalBtn
            anchors.centerIn: parent
            text: '审批'
            onClicked: {
                pageStack.push(Qt.resolvedUrl('CDoodApprovalPage.qml'))
            }
        }
        CButton {
            id: orgBtn

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: approvalBtn.bottom
            anchors.topMargin: 30
            text: '组织架构'
            onClicked: {
//                ApprovalRequest.getJSONFile(onGetJSONFile)
                console.log('1111111111111111111111111111111111')
                var component = pageStack.push(Qt.resolvedUrl('./enterprise/SelectApprovalUser.qml'));
                component.callback.connect(function(obj){
                    console.log("id:"+obj.id+',name:'+obj.name);
                });
            }
        }
    }

    function onGetJSONFile(ret) {
        var obj = JSON.parse(ret)
        console.log('Danger test:' + obj.staffList[0].userID)
        mainApp.currentID = obj.staffList[0].userID
        mainApp.currentName = obj.staffList[0].userName
    }
}
