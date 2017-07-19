import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: businessTripApprovalPage

    property real scale: 1.92
    property string selectedUserID: ''
    property string selectedName: ''
    property string selectedPortrait: ''
    property alias submitButtonEnabled: submitButton.enabled

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
                height: gUtill.dpH2(64 * businessTripApprovalPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * businessTripApprovalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * businessTripApprovalPage.scale)

                    text: qsTr('审批申请')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * businessTripApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * businessTripApprovalPage.scale)
                    height: gUtill.dpH2(22 * businessTripApprovalPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * businessTripApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * businessTripApprovalPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * businessTripApprovalPage.scale)
                        height: gUtill.dpH2(20 * businessTripApprovalPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * businessTripApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * businessTripApprovalPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * businessTripApprovalPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * businessTripApprovalPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: {
                            if (siteInputTextArea.length > 0) {
                                backTipDialog.show()
                            }
                            else {
                                pageStack.pop()
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: siteInputArea

                property int length: siteInputTextArea.length

                width: parent.width
                height: gUtill.dpH2(50 * businessTripApprovalPage.scale)
                anchors.top: titleArea.bottom
                color: 'white'

                Text {
                    id: approvalDescriptionTip

                    height: gUtill.dpH2(22 * businessTripApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * businessTripApprovalPage.scale)
                        verticalCenter: parent.verticalCenter
                    }

                    text: '出差地点'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Qt.AlignVCenter
                }

                CTextField {
                    id: siteInputTextArea

                    anchors {
                        left: approvalDescriptionTip.right
                        leftMargin: gUtill.dpW2(24.5 * businessTripApprovalPage.scale)
                        right: parent.right
                        rightMargin: gUtill.dpW2(15 * businessTripApprovalPage.scale)
                        verticalCenter: parent.verticalCenter
                    }

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                    textColor: '#868687'
                    horizontalAlignment: TextEdit.AlignRight
                    placeholderText: '请输入出差地点(必填)'
                    placeholderTextItem.horizontalAlignment: Qt.AlignRight
                    placeholderTextItem.color: '#C7C7CC'
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            UserProfileButton {
                id: startTimeButton

                width: parent.width
                height: gUtill.dpH2(50 * businessTripApprovalPage.scale)
                anchors.top: siteInputArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * businessTripApprovalPage.scale)

                leftText: qsTr("开始时间")
                leftTextColor: '#545454'
                leftTextFont {
                    family: 'PingFangSC-Regular'
                    pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                }

                rightTextColor: '#545454'
                rightTextFont {
                    family: 'PingFangSC-Regular'
                    pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                }

                editable: true

                onClicked: {
                    datePicker.dialogTitle = '请选择开始时间'
                    datePicker.isStart = true
                    datePicker.show();
                }

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            UserProfileButton {
                id: endTimeButton

                width: parent.width
                height: gUtill.dpH2(50 * businessTripApprovalPage.scale)
                anchors.top: startTimeButton.bottom

                leftText: qsTr("结束时间")
                leftTextColor: '#545454'
                leftTextFont {
                    family: 'PingFangSC-Regular'
                    pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                }

                rightTextColor: '#545454'
                rightTextFont {
                    family: 'PingFangSC-Regular'
                    pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                }

                editable: true

                onClicked: {
                    datePicker.dialogTitle = '请选择结束时间'
                    datePicker.isStart = false
                    datePicker.show();
                }

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            Rectangle {
                id: reasonTextArea

                //property int length: approvalDescriptionContent.length

                width: parent.width
                height: gUtill.dpH2(100 * businessTripApprovalPage.scale)
                anchors.top: endTimeButton.bottom
                anchors.topMargin: gUtill.dpH2(10 * businessTripApprovalPage.scale)

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: businessTripReasonTip

                    height: gUtill.dpH2(22 * businessTripApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * businessTripApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * businessTripApprovalPage.scale)
                    }

                    text: '出差原因'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Qt.AlignVCenter
                }

                CTextArea {
                    id: businessTripReasonContentTextArea

                    anchors {
                        top: parent.top
                        topMargin: gUtill.dpH2(12.5 * businessTripApprovalPage.scale)
                        left: businessTripReasonTip.right
                        leftMargin: gUtill.dpW2(24.5 * businessTripApprovalPage.scale)
                        right: parent.right
                        rightMargin: gUtill.dpW2(15 * businessTripApprovalPage.scale)
                        bottom: parent.bottom
                        bottomMargin: gUtill.dpH2(13 * businessTripApprovalPage.scale)
                    }

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                    textColor: '#868687'
                    placeholderText: '请输入出差原因'
                    placeholderTextItem.horizontalAlignment: Qt.AlignRight
                    placeholderTextItem.color: '#C7C7CC'
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            Rectangle {
                id: addApproverArea

                width: parent.width
                height: gUtill.dpH2(120 * businessTripApprovalPage.scale)
                anchors.top: reasonTextArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * businessTripApprovalPage.scale)

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: addApproverDescription

                    height: gUtill.dpH2(22 * businessTripApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * businessTripApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * businessTripApprovalPage.scale)
                    }

                    text: '添加审批人'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Text.AlignVCenter
                }

                CDoodHeaderImage {
                    id: addApproverIcon

                    width: gUtill.dpW2(45 * businessTripApprovalPage.scale)
                    height: gUtill.dpH2(45 * businessTripApprovalPage.scale)
                    anchors{
                        top: addApproverDescription.bottom
                        topMargin: gUtill.dpH2(6 * businessTripApprovalPage.scale)
                        left: parent.left
                        leftMargin: gUtill.dpW2(15 * businessTripApprovalPage.scale)
                    }

                    iconSource: selectedUserID ===''
                                ? setIcon('1', 'qrc:/res/approval/ic_add.png')
                                : setIcon('1', selectedPortrait)

                    MouseArea {
                        id: mouseareaAddApprover

                        anchors.fill: parent
                        onClicked: {
                            var component = pageStack.push(Qt.resolvedUrl('./enterprise/SelectApprovalUser.qml'));
                            component.callback.connect(function(obj){
                                console.log("id:"+obj.id+',name:'+obj.name);
                                selectedUserID = obj.id;
                                selectedName = obj.name;
                            });
                        }
                    }
                }
                Text {
                    id: addApproverName

                    height: gUtill.dpH2(22 * businessTripApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * businessTripApprovalPage.scale)
                        top: addApproverIcon.bottom
                        topMargin: gUtill.dpH2(6 * businessTripApprovalPage.scale)
                    }

                    text: selectedName
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                    color: '#C7C7CC'
                    verticalAlignment: Text.AlignVCenter
                }
                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            Rectangle {
                id: submitButton

                width: parent.width
                height: gUtill.dpH2(49 * businessTripApprovalPage.scale)
                anchors.bottom: parent.bottom
                color: enabled ? '#577EDD' : '#A2BCE8'
                enabled: siteInputTextArea.text.length > 0
                         && selectedUserID !== ''
                         && startTimeButton.rigthText.length > 0
                         && endTimeButton.rigthText.length > 0

                Text {
                    id: submitText

                    height: gUtill.dpH2(22 * businessTripApprovalPage.scale)
                    anchors.centerIn: parent

                    text: '提交'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * businessTripApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (submitButton.enabled) {
                            var content = {}
                            content.begin_date = startTimeButton.rigthText
                            content.end_date = endTimeButton.rigthText
                            content.pos_change_to = siteInputTextArea.text
                            content.outReaSon = businessTripReasonContentTextArea.text
                            var createUser = {}
                            createUser.userID = selectedUserID
                            createUser.userName = selectedName
                            createUser.userPhotoUrl = selectedPortrait
                            var approver = {}
                            approver.userID = selectedUserID
                            approver.userName = selectedName
                            approver.userPhotoUrl = selectedPortrait
                            ApprovalRequest.addNewApprovalEvent(8,
                                                                createUser,
                                                                approver,
                                                                JSON.stringify(content),
                                                                [],
                                                                onSendResult)

                            indicator.visible = true
                            submitButtonEnabled = false
                        }
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

    CDatePickerDialog {
        id: datePicker
        property string dialogTitle
        property bool isStart: true
        titleText: dialogTitle
        onDateAccepted: {
            if (isStart) {
                startTimeButton.rigthText = year + "-" + month + "-" + day
            }
            else {
                endTimeButton.rigthText = year + "-" + month + "-" + day
            }
        }
    }

    CDialog {
        id: backTipDialog
        titleAreaEnabled: false
        messageText: "当前审批尚未提交，直接返回，系统不保留您已录入的内容，请确认您的操作"
        acceptedButtonText: '<font color=\"#0076FF\">确认返回</font>'
        rejectButtonText: '<font color=\"#0076FF\">暂不返回</font>'
        onAccepted: pageStack.pop()
    }

    function onSendResult(ret) {
        indicator.visible = false
        submitButtonEnabled = true
        var obj = JSON.parse(ret)
        if (obj.code === 1) {
            gToast.requestToast("审批已提交","","");
            pageStack.pop()
        }
        else {
            gToast.requestToast("发送失败","","");
        }
    }
}
