import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: approvalRejectPage

    property real scale: 1.92
    property var undeterminedApprovalPageId
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
                height: gUtill.dpH2(64 * approvalRejectPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * approvalRejectPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * approvalRejectPage.scale)

                    text: qsTr('驳回申请')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * approvalRejectPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * approvalRejectPage.scale)
                    height: gUtill.dpH2(22 * approvalRejectPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * approvalRejectPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * approvalRejectPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * approvalRejectPage.scale)
                        height: gUtill.dpH2(20 * approvalRejectPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * approvalRejectPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * approvalRejectPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * approvalRejectPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * approvalRejectPage.scale)
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
                height: gUtill.dpH2(100 * approvalRejectPage.scale)
                anchors.top: titleArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * approvalRejectPage.scale)
                color: 'white'

                CLine {
                    anchors.top: parent.top
                    height: gUtill.dpH2(1 * approvalRejectPage.scale)
                    color: '#DDDFEB'
                }

                CTextArea {
                    id: approvalOpinionText

                    anchors.fill: parent
                    anchors.margins: gUtill.dpH2(13 * approvalRejectPage.scale)

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * approvalRejectPage.scale)
                    textColor: '#868687'
                    placeholderText: '请输入驳回原因(必填项)'
                    placeholderTextItem.color: '#545454'
                    maximumLength: 200

                    Text {
                        id: rightPlaceholderTextComponent

                        anchors.fill: parent

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
                    height: gUtill.dpH2(1 * approvalRejectPage.scale)
                    color: '#DDDFEB'
                }
            }

            Rectangle {
                id: rejectButton

                width: parent.width
                height: gUtill.dpH2(49 * approvalRejectPage.scale)
                anchors.bottom: parent.bottom
                color: enabled ? '#577EDD' : '#A2BCE8'
                enabled: approvalOpinionText.length
                         && !indicator.visible

                Text {
                    id: buttenTip
                    anchors.centerIn: parent
                    text: '确认驳回'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * approvalRejectPage.scale)
                    color: 'white'
                }

                MouseArea {
                    id: buttonArea
                    anchors.fill: parent
                    onClicked: {
                        ApprovalRequest.updateApprovalEventStatus(approvalID, 0,
                            mainApp.currentID, -1, approvalOpinionText.text, {}, [],
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
        messageText: "确定放弃“驳回”操作"
        acceptedButtonText: '<font color=\"#0076FF\">确定</font>'
        rejectButtonText: '<font color=\"#0076FF\">取消</font>'
        onAccepted: pageStack.pop()
    }
}
