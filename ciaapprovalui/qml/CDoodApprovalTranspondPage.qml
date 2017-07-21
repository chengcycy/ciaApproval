import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: approvalTranspondPage

    property var  undeterminedApprovalPageId
    property real scale: 1.92
    property string selectedUserID: ''
    property string selectedName: ''
    property string selectedPortrait: ''
    property var approvalID
    signal callback(var json)

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
                height: gUtill.dpH2(64 * approvalTranspondPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * approvalTranspondPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * approvalTranspondPage.scale)

                    text: qsTr('转批申请')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * approvalTranspondPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * approvalTranspondPage.scale)
                    height: gUtill.dpH2(22 * approvalTranspondPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * approvalTranspondPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * approvalTranspondPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * approvalTranspondPage.scale)
                        height: gUtill.dpH2(20 * approvalTranspondPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * approvalTranspondPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * approvalTranspondPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * approvalTranspondPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * approvalTranspondPage.scale)
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
                id: addApproverArea

                width: parent.width
                height: gUtill.dpH2(100 * approvalTranspondPage.scale)
                anchors.top: titleArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * approvalTranspondPage.scale)

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: addApproverDescription

                    height: gUtill.dpH2(22 * approvalTranspondPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * approvalTranspondPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * approvalTranspondPage.scale)
                    }

                    text: '转批对象'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * approvalTranspondPage.scale)
                    color: '#545454'
                    verticalAlignment: Text.AlignVCenter
                }

                CDoodHeaderImage {
                    id: addApproverIcon

                    width: gUtill.dpW2(45 * approvalTranspondPage.scale)
                    height: gUtill.dpH2(45 * approvalTranspondPage.scale)
                    anchors{
                        top: addApproverDescription.bottom
                        topMargin: gUtill.dpH2(6 * approvalTranspondPage.scale)
                        left: parent.left
                        leftMargin: gUtill.dpW2(15 * approvalTranspondPage.scale)
                    }

                    iconSource: selectedUserID ==='' ?
                                    setIcon('1', 'qrc:/res/approval/ic_add.png') :
                                    setIcon('1', selectedPortrait)

                    MouseArea {
                        id: mouseareaAddApprover

                        anchors.fill: parent
                        onClicked: {
                            loadingOrg.show();
                            ApprovalRequest.getContactsJSONFile(function(resp){
                                console.log('=================================contact:'+resp);
                                orgManager.resetDataFromJson(resp);
                                var orgName = orgManager.nameById(1);

                                orgNavBarManager.clear();
                                orgNavBarManager.setNav(1,orgName);
                                loadingOrg.hide();
                                var component = pageStack.push(Qt.resolvedUrl('./enterprise/SelectApprovalUser.qml'));
                                component.callback.connect(function(obj) {
                                    console.log("id:"+obj.id+',name:'+obj.name);
                                    selectedUserID = obj.id;
                                    selectedName = obj.name;
                                });
                            });
                        }
                    }
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            Rectangle {
                id: editBackground

                width: parent.width
                height: gUtill.dpH2(100 * approvalTranspondPage.scale)
                anchors.top: addApproverArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * approvalTranspondPage.scale)
                color: 'white'

                CLine {
                    anchors.top: parent.top
                    height: gUtill.dpH2(1 * approvalTranspondPage.scale)
                    color: '#DDDFEB'
                }

                CTextArea {
                    id: approvalOpinionText

                    anchors.fill: parent
                    anchors.margins: gUtill.dpH2(13 * approvalTranspondPage.scale)

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * approvalTranspondPage.scale)
                    textColor: '#868687'
                    placeholderText: '请输入转批留言(非必填)'
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
                    height: gUtill.dpH2(1 * approvalTranspondPage.scale)
                    color: '#DDDFEB'
                }
            }

            Rectangle {
                id: transpondButton

                width: parent.width
                height: gUtill.dpH2(49 * approvalTranspondPage.scale)
                anchors.bottom: parent.bottom
                color: enabled ? '#577EDD' : '#A2BCE8'
                enabled: selectedUserID !== ''
                         && !indicator.visible

                Text {
                    id: buttenTip
                    anchors.centerIn: parent
                    text: '确认转批'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * approvalTranspondPage.scale)
                    color: 'white'
                }

                MouseArea {
                    id: buttonArea
                    anchors.fill: parent
                    onClicked: {
                        var approver = {}
                        approver.userID = selectedUserID
                        approver.userName = selectedName
                        approver.userPhotoUrl = selectedPortrait
                        ApprovalRequest.updateApprovalEventStatus(approvalID, 0,
                            mainApp.currentID, 3, approvalOpinionText.text, approver, [],
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
                                    ApprovalRequest.showHasApprovalDetial(approvalID,
                                        function(ret) {
                                            emit: callback(ret);
                                        })
                                    pageStack.pop()
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

            CIndicatorDialog {
                id:loadingOrg
                messageText: os.i18n.ctr(qsTr("正在拉取数据..."))
                messageTextPixelSize:gUtill.dpH2(32);
            }
        }
    }

    CDialog {
        id: backTipDialog
        titleAreaEnabled: false
        messageText: "确定放弃“转批”操作"
        acceptedButtonText: '<font color=\"#0076FF\">确定</font>'
        rejectButtonText: '<font color=\"#0076FF\">取消</font>'
        onAccepted: pageStack.pop()
    }
}
