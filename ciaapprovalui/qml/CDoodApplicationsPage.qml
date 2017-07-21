import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest
import '../'

Item {
    id: applicationsPage

    property real scale: 1.92

    anchors.fill: parent

    Connections {
        target: approvalManager
        onUserOutAuthResult: {
            if (type === 1) {
                return;
            }
            if (trustLevel === 0) {
                storeAppManager.openAppUrl("email://");
            }
            else {
                if (trustLevel === -2) {
                    alertDlg.messageText = "验证失败，请检查网络"
                }
                else {
                    alertDlg.messageText = "您目前无权在移动端使用邮件服务"
                }
                alertDlg.show()
            }
        }
    }

    Rectangle {
        id: backgroundArea
        anchors.fill: parent
        color: '#F7F7F6'

        Rectangle {
            id: titleArea

            width: parent.width
            height: gUtill.dpH2(76*fp)
            anchors.top: parent.top

            color: '#394871'

            Text {
                id: textTitle

                anchors.centerIn: parent
                text: '应用'
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(32*fp)
                color: 'white'
                verticalAlignment: Qt.AlignBottom
            }
        }

        Image {
            id: titleImage
            width: parent.width
            height: gUtill.dpH2(190 * applicationsPage.scale)
            anchors.top: titleArea.bottom
            sourceSize.width: width
            sourceSize.height: height
            source: 'qrc:/res/Rectangle.png'
        }

        GridView {
            id: applicationsTable

            width: parent.width
            anchors.top: titleImage.bottom
            anchors.bottom: parent.bottom

            cellWidth: width / 4
            cellHeight: gUtill.dpH2(100 * applicationsPage.scale)

            delegate: applicationsDelegate
            model: storePartAppManager

            clip: true

            Component.onCompleted: {
                headerItem.text = '审批管理'
            }
        }

        Component {
            id: applicationsDelegate

            Item {
                id: applicationsTableDelegateArea

                width: applicationsPage.width / 4
                height: gUtill.dpH2(100 * applicationsPage.scale)

                Rectangle {
                    id: delegateButton

                    width: delegateText.contentWidth
                    height: gUtill.dpH2(68 * applicationsPage.scale)
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(20 * applicationsPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: 'transparent'

                    CDoodRecHeaderImage{
                        id: delegateIcon

                        width: gUtill.dpW2(42 * applicationsPage.scale)
                        height: gUtill.dpH2(42 * applicationsPage.scale)
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter

                        name:model.modelData.name
                        iconSource:setIcon("3", model.modelData.avatar)

                    }

                    Text {
                        id: delegateText

                        height: gUtill.dpH2(18 * applicationsPage.scale)
                        anchors.top: delegateIcon.bottom
                        anchors.topMargin: gUtill.dpH2(8 * applicationsPage.scale)

                        text: model.modelData.name
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(13 * applicationsPage.scale)
                        color: '#545454'
                        verticalAlignment: Qt.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaDelegate
                        anchors.fill: parent
                        onClicked: {
                            if(model.modelData.id==="110"){
                                pageStack.push(Qt.resolvedUrl("CDoodApplicationStorePage.qml"));
                            }
                            else{
                                if(model.modelData.name === "审批"){
                                    pageStack.push(Qt.resolvedUrl("CDoodApprovalPage.qml"));
                                    return;
                                }
                                else if(model.modelData.name === qsTr("邮件")) {
//                                    if (approvalManager.trustLevel === -1) {
//                                        alertDlg.messageText = "请等待验证结果"
//                                        alertDlg.show()
//                                    }
//                                    else {
//                                        approvalManager.userOutAuth(0)
//                                    }
                                    ApprovalRequest.userOutAuth(userProfileManager.id,
                                                                onAuthResult)
                                    return;
                                }

                                var url = model.modelData.url;
                                //if(model.modelData.name === qsTr("邮件")){
                                url = url+loginManager.lastLoginAccountName();
                                //}
                                storeAppManager.openAppUrl(url);
                            }
                        }
                    }
                }
            }
        }
    }

    CAlertDialog {
        id: alertDlg
        titleAreaEnabled: false
        messageText: approvalManager.distrustReason
    }

    function onAuthResult(ret) {
        //indicator.visible = false
        var obj = JSON.parse(ret)
        if (obj.code === 200 && obj.trust_level === 0) {
            storeAppManager.openAppUrl("email://");
        }
        else {
            if (obj.code !== 200) {
                alertDlg.messageText = "通信失败，请检查网络"
            }
            else {
                alertDlg.messageText = "您目前无权在移动端使用邮件服务"
            }
            alertDlg.show()
        }
    }
}


