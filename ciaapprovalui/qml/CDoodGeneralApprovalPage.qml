import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: generalApprovalPage

    property real scale: 1.92
    property int approvalType: 0
    property string selectedUserID: ''
    property string selectedName: ''
    property string selectedPortrait: ''
    property alias submitButtonEnabled: submitButton.enabled
    property var typeList: [qsTr("通用"),qsTr("报销"),qsTr("请假"),qsTr("出差"),qsTr("外出"),qsTr("采购"),qsTr("转正")/*,qsTr("调休")*/]

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
                height: gUtill.dpH2(64 * generalApprovalPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * generalApprovalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * generalApprovalPage.scale)

                    text: qsTr('审批申请')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * generalApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * generalApprovalPage.scale)
                    height: gUtill.dpH2(22 * generalApprovalPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * generalApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * generalApprovalPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * generalApprovalPage.scale)
                        height: gUtill.dpH2(20 * generalApprovalPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * generalApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * generalApprovalPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * generalApprovalPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * generalApprovalPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: {
                            if (contextTextArea.length > 0) {
                                backTipDialog.show()
                            }
                            else {
                                pageStack.pop()
                            }
                        }
                    }
                }
            }

            UserProfileButton {
                id: addTypeButton

                width: parent.width
                height: gUtill.dpH2(50 * generalApprovalPage.scale)
                anchors.top: titleArea.bottom

                leftText: qsTr("审批类型")
                leftTextColor: '#545454'
                leftTextFont {
                    family: 'PingFangSC-Regular'
                    pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
                }

                rigthText: typeList[generalApprovalPage.approvalType]
                rightTextColor: '#545454'
                rightTextFont {
                    family: 'PingFangSC-Regular'
                    pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
                }

                editable: true

                onClicked: {
                    typeListDialog.select(generalApprovalPage.approvalType, true)
                    typeListDialog.show();
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            Rectangle {
                id: contextTextArea

                property int length: approvalDescriptionContent.length

                width: parent.width
                height: gUtill.dpH2(100 * generalApprovalPage.scale)
                anchors.top: addTypeButton.bottom
                anchors.topMargin: gUtill.dpH2(10 * generalApprovalPage.scale)

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: approvalDescriptionTip

                    height: gUtill.dpH2(22 * generalApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * generalApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * generalApprovalPage.scale)
                    }

                    text: '审批描述'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Qt.AlignVCenter
                }

                CTextArea {
                    id: approvalDescriptionContent

                    anchors {
                        top: parent.top
                        topMargin: gUtill.dpH2(12.5 * generalApprovalPage.scale)
                        left: approvalDescriptionTip.right
                        leftMargin: gUtill.dpW2(24.5 * generalApprovalPage.scale)
                        right: parent.right
                        rightMargin: gUtill.dpW2(15 * generalApprovalPage.scale)
                        bottom: parent.bottom
                        bottomMargin: gUtill.dpH2(13 * generalApprovalPage.scale)
                    }

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
                    textColor: '#868687'
                    placeholderText: '请输入审批描述(必填)'
                    placeholderTextItem.horizontalAlignment: Qt.AlignRight
                    placeholderTextItem.color: '#C7C7CC'
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            Rectangle {
                id: imagesArea

                width: parent.width
                height: gUtill.dpH2((imagesList.visible ? 116.5 : 50)
                                    * generalApprovalPage.scale)
                anchors.top: contextTextArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * generalApprovalPage.scale)

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: imageTipText

                    height: gUtill.dpH2(22 * generalApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * generalApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * generalApprovalPage.scale)
                    }

                    text: '图片'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Text.AlignVCenter
                }

                Image {
                    id: imageIcon
                    width: gUtill.dpW2(30 * generalApprovalPage.scale)
                    height: gUtill.dpH2(25 * generalApprovalPage.scale)
                    anchors{
                        right: parent.right
                        rightMargin: 20
                        verticalCenter: imageTipText.verticalCenter
                    }
                    source: "qrc:/res/approval/xiangji@2x.png"

                    MouseArea {
                        id: addImageArea
                        anchors.fill: parent
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl('../CDoodViewLocalImagePage.qml'),
                                           {isApproval: true});
                        }
                    }
                }

                Row {
                    id: imagesList
                    anchors.top: imageTipText.bottom
                    anchors.topMargin: gUtill.dpH2(10 * generalApprovalPage.scale)
                    anchors.left: imageTipText.left
                    spacing: gUtill.dpW2(10 * generalApprovalPage.scale)
                    visible: imagesContainer.count !== 0
                    Repeater {
                        id: imagesContainer
                        model: approvalManager.approvalAttachmentModel
                        Item {
                            id: imageFrame
                            width: gUtill.dpW2(57.5 * generalApprovalPage.scale)
                            height: gUtill.dpH2(57.5 * generalApprovalPage.scale)

                            Image {
                                id: image
                                width: gUtill.dpW2(45 * generalApprovalPage.scale)
                                height: gUtill.dpH2(45 * generalApprovalPage.scale)
                                anchors.left: parent.left
                                anchors.bottom: parent.bottom
                                source: 'file:///' + model.modelData.path
                            }
                            Image {
                                id: removeImageIcon
                                width: gUtill.dpW2(25 * generalApprovalPage.scale)
                                height: gUtill.dpH2(25 * generalApprovalPage.scale)
                                anchors.top: parent.top
                                anchors.right: parent.right
                                source: 'qrc:/res/approval/ic_list_Delete Reveal.png'
                                //fillMode:

                                MouseArea {
                                    id: removeImageArea
                                    anchors.fill: parent
                                    onClicked: approvalManager.removeImage(index)
                                }
                            }
                        }
                    }
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }
            }

            Rectangle {
                id: addApproverArea

                width: parent.width
                height: gUtill.dpH2(120 * generalApprovalPage.scale)
                anchors.top: imagesArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * generalApprovalPage.scale)

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: addApproverDescription

                    height: gUtill.dpH2(22 * generalApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * generalApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * generalApprovalPage.scale)
                    }

                    text: '添加审批人'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Text.AlignVCenter
                }

                CDoodHeaderImage {
                    id: addApproverIcon

                    width: gUtill.dpW2(45 * generalApprovalPage.scale)
                    height: gUtill.dpH2(45 * generalApprovalPage.scale)
                    anchors{
                        top: addApproverDescription.bottom
                        topMargin: gUtill.dpH2(6 * generalApprovalPage.scale)
                        left: parent.left
                        leftMargin: gUtill.dpW2(15 * generalApprovalPage.scale)
                    }

                    iconSource: generalApprovalPage.selectedUserID ===''
                                ? setIcon('1', 'qrc:/res/approval/ic_add.png')
                                : setIcon('1', generalApprovalPage.selectedPortrait)

                    MouseArea {
                        id: mouseareaAddApprover

                        anchors.fill: parent
                        onClicked: {
                            ApprovalRequest.getContactsJSONFile(function(resp){
                                console.log('=================================contact:'+resp);
                                orgManager.resetDataFromJson(resp);
                                var orgName = orgManager.nameById(1);

                                orgNavBarManager.clear();
                                orgNavBarManager.setNav(1,orgName);
                                var component = pageStack.push(Qt.resolvedUrl('./enterprise/SelectApprovalUser.qml'));
                                component.callback.connect(function(obj){
                                    console.log("id:"+obj.id+',name:'+obj.name);
                                    selectedUserID = obj.id;
                                    selectedName = obj.name;
                                });
                            });
                        }
                    }
                }
                Text {
                    id: addApproverName

                    height: gUtill.dpH2(22 * generalApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * generalApprovalPage.scale)
                        top: addApproverIcon.bottom
                        topMargin: gUtill.dpH2(6 * generalApprovalPage.scale)
                    }

                    text: generalApprovalPage.selectedName
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
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
                height: gUtill.dpH2(49 * generalApprovalPage.scale)
                anchors.bottom: parent.bottom
                color: enabled ? '#577EDD' : '#A2BCE8'
                enabled: contextTextArea.length > 0
                         && generalApprovalPage.selectedUserID !== ''

                Text {
                    id: submitText

                    height: gUtill.dpH2(22 * generalApprovalPage.scale)
                    anchors.centerIn: parent

                    text: '提交'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * generalApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var createUser = {}
                        createUser.userID = mainApp.currentID
                        createUser.userName = mainApp.currentName
                        createUser.userPhotoUrl = ''
                        var approver = {}
                        approver.userID = selectedUserID
                        approver.userName = selectedName
                        approver.userPhotoUrl = selectedPortrait
                        ApprovalRequest.addNewApprovalEvent(approvalType,
                                                            createUser, approver, approvalDescriptionContent.text, [],
                                                            onSendResult)
                        indicator.visible = true
                        submitButtonEnabled = false
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

    CDoodListDialog{
        id: typeListDialog

        titleText: qsTr("审批类型")
        model: typeList
        onNotifySelectedItems:{
            addTypeButton.rigthText = model[curIndex]
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
            selectedUserID = ''
            selectedName = ''
            selectedPortrait = ''
            pageStack.pop()
        }
        else {
            gToast.requestToast("发送失败","","");
        }
    }
}
