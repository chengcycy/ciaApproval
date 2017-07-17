import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPageStackWindow {
    initialPage:CPage{
        width:parent.width
        height:parent.height
        CButton {
            id: approvalBtn
            anchors.centerIn: parent
            text: '审批'
            onClicked: {
                ApprovalRequest.getJSONFile(onGetJSONFile)
                pageStack.push(Qt.resolvedUrl('CDoodApprovalPage.qml'))
            }
        }
    }

    function onGetJSONFile(ret) {
        console.log('Danger test:' + JSON.stringify(ret))
    }
}
