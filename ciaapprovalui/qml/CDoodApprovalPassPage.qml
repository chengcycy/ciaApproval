import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: approvalPassPage

    property real scale: 1.92
    property var  undeterminedApprovalPageId
    property var approvalID

    statusBarHoldEnabled: false
    Component.onCompleted: {
        //设置是否显示状态栏，应与statusBarHoldItemEnabled属性一致
        gScreenInfo.setStatusBar(true);

        //设置状态栏样式，取值为"black"，"white"，"transwhite"和"transblack"
        gScreenInfo.setStatusBarStyle("transwhite");
    }

    contentAreaItem: Item {
        anchors.fill: parent

        Rectangle {
            id: backgroundArea
            anchors.fill: parent
            color: '#F7F7F6'

            Rectangle {
                id: titleArea

                width: parent.width
                height: gUtill.dpH2(64 * approvalPassPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * approvalPassPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * approvalPassPage.scale)

                    text: qsTr('同意申请')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * approvalPassPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * approvalPassPage.scale)
                    height: gUtill.dpH2(22 * approvalPassPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * approvalPassPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * approvalPassPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * approvalPassPage.scale)
                        height: gUtill.dpH2(20 * approvalPassPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * approvalPassPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * approvalPassPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * approvalPassPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * approvalPassPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: {
                            if (approvalOpinionText.length > 0) {
                                backTipDialog.show()
                            }
                            else {
                                pageStack.pop();
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: editBackground

                width: parent.width
                height: gUtill.dpH2(100 * approvalPassPage.scale)
                anchors.top: titleArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * approvalPassPage.scale)
                color: 'white'

                CLine {
                    anchors.top: parent.top
                    height: gUtill.dpH2(1 * approvalPassPage.scale)
                    color: '#DDDFEB'
                }

                CTextArea {
                    id: approvalOpinionText

                    anchors.fill: parent
                    //anchors.margins: gUtill.dpH2(13 * approvalPassPage.scale)

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * approvalPassPage.scale)
                    textColor: '#868687'
                    placeholderText: '请输入同意理由(非必填)'
                    placeholderTextItem.color: '#545454'
                    textMargin: gUtill.dpH2(13 * approvalPassPage.scale)
                    maximumLength: 200

                    Text {
                        id: rightPlaceholderTextComponent

                        anchors.fill: parent
                        anchors.margins: parent.placeholderTextItem.anchors.margins

                        text: '不超过200字'
                        color: "#C7C7CC";
                        font: parent.font
                        horizontalAlignment: Qt.AlignRight
                        wrapMode: Text.Wrap
                        opacity: parent.placeholderTextItem.opacity
                        Behavior on opacity { NumberAnimation { duration: gSystemUtils.durationRatio*100 } }
                    }
                }

                CLine {
                    anchors.bottom: parent.bottom
                    height: gUtill.dpH2(1 * approvalPassPage.scale)
                    color: '#DDDFEB'
                }
            }

            Rectangle {
                id: passButton

                width: parent.width
                height: gUtill.dpH2(49 * approvalPassPage.scale)
                anchors.bottom: parent.bottom
                color: enabled ? '#577EDD' : '#A2BCE8'
                enabled: !indicator.visible

                Text {
                    id: buttenTip
                    anchors.centerIn: parent
                    text: '确认同意'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * approvalPassPage.scale)
                    color: 'white'
                }

                MouseArea {
                    id: buttonArea
                    anchors.fill: parent
                    onClicked: {
                        ApprovalRequest.updateApprovalEventStatus(approvalID, 0,
                            mainApp.currentID, 2, approvalOpinionText.text, {}, [],
                            function(ret) {
                                indicator.visible = false

                                try {
                                    var obj = JSON.parse(ret)
                                }
                                catch (err) {
                                    gToast.requestToast("处理失败");
                                    return;
                                }

                                if (obj.code === 1) {
                                    pageStack.pop(undeterminedApprovalPageId)
                                }
                                else {
                                    gToast.requestToast('处理失败');
                                }
                            })
                        indicator.visible = true
                    }
                }
            }

            CCircularIndicator {
                id: indicator
                anchors.centerIn: parent
                visible: false
            }
        }
    }

    CDialog {
        id: backTipDialog
        titleAreaEnabled: false
        messageText: "确定放弃“同意”操作"
        acceptedButtonText: '<font color=\"#0076FF\">确定</font>'
        rejectButtonText: '<font color=\"#0076FF\">取消</font>'
        onAccepted: pageStack.pop()
    }
}
