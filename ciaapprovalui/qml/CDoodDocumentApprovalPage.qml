﻿import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: documentApprovalPage

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

        documentListModel.clear()
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
                height: gUtill.dpH2(64 * documentApprovalPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * documentApprovalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * documentApprovalPage.scale)

                    text: qsTr('公文审批')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * documentApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * documentApprovalPage.scale)
                    height: gUtill.dpH2(22 * documentApprovalPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * documentApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * documentApprovalPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * documentApprovalPage.scale)
                        height: gUtill.dpH2(20 * documentApprovalPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * documentApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * documentApprovalPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * documentApprovalPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * documentApprovalPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: {
                            if (contextTextArea.length > 0
                                    || approvalDocumentList.count > 0) {
                                backTipDialog.show()
                            }
                            else {
                                pageStack.pop()
                            }
                        }
                    }
                }
            }

            ListView {
                id: approvalDocumentList

                width: parent.width
                height: gUtill.dpH2(count * 49 * documentApprovalPage.scale)
                anchors.top: titleArea.bottom
                model: documentListModel
                delegate: fillItemDelegate
                clip: true
            }

            Rectangle {
                id: addFilesButton

                width: parent.width
                height: gUtill.dpH2(50 * documentApprovalPage.scale)
                anchors.top: approvalDocumentList.bottom

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Rectangle {
                    id: addFilesTip

                    width: addFilesIcon.width + addFilesText.contentWidth
                           + gUtill.dpW2(5 * documentApprovalPage.scale)
                    height: gUtill.dpH2(22 * documentApprovalPage.scale)
                    anchors.centerIn: parent

                    Image {
                        id: addFilesIcon

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        sourceSize.width: gUtill.dpW2(18 * documentApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(18 * documentApprovalPage.scale)

                        source: 'qrc:/res/approval/ic_add to.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: addFilesText

                        height: gUtill.dpH2(22 * documentApprovalPage.scale)
                        anchors.left: addFilesIcon.right
                        anchors.leftMargin: gUtill.dpW2(5 * documentApprovalPage.scale)
                        anchors.verticalCenter: parent.verticalCenter

                        text: '请选择待审批公文文件'
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(16 * documentApprovalPage.scale)
                        color: '#577EDD'
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                CLine {
                    anchors.bottom: parent.bottom
                    color: '#FFDDDFEB'
                }

                MouseArea {
                    id: mouseAreaAddFiles
                    anchors.fill: parent
                    onClicked: {
                        if (selectedUserID === '') {
                            gToast.requestToast("请先选择审批人");
                            return;
                        }

                        var component = pageStack.push(Qt.resolvedUrl('CDoodApprovalDocumentListPage.qml'),
                                       {selectedUserID: selectedUserID});
                        component.callback.connect(function(ret) {
                            documentListModel.clear()
                            for (var i = 0; i < ret.length; i++) {
                                documentListModel.append(ret[i])
                            }
                        })
                    }
                }
            }

            Rectangle {
                id: contextTextArea

                property int length: approvalDescriptionContent.length

                width: parent.width
                height: gUtill.dpH2(100 * documentApprovalPage.scale)
                anchors.top: addFilesButton.bottom
                anchors.topMargin: gUtill.dpH2(10 * documentApprovalPage.scale)

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: approvalDescriptionTip

                    height: gUtill.dpH2(22 * documentApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * documentApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * documentApprovalPage.scale)
                    }

                    text: '审批描述'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * documentApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Qt.AlignVCenter
                }

                CTextArea {
                    id: approvalDescriptionContent

                    anchors {
                        top: parent.top
                        topMargin: gUtill.dpH2(12.5 * documentApprovalPage.scale)
                        left: approvalDescriptionTip.right
                        leftMargin: gUtill.dpW2(24.5 * documentApprovalPage.scale)
                        right: parent.right
                        rightMargin: gUtill.dpW2(15 * documentApprovalPage.scale)
                        bottom: parent.bottom
                        bottomMargin: gUtill.dpH2(13 * documentApprovalPage.scale)
                    }

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * documentApprovalPage.scale)
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
                id: addApproverArea

                width: parent.width
                height: gUtill.dpH2(120 * documentApprovalPage.scale)
                anchors.top: contextTextArea.bottom
                anchors.topMargin: gUtill.dpH2(10 * documentApprovalPage.scale)

                color: 'white'

                CLine {
                    anchors.top: parent.top
                    color: '#FFDDDFEB'
                }

                Text {
                    id: addApproverDescription

                    height: gUtill.dpH2(22 * documentApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * documentApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(13 * documentApprovalPage.scale)
                    }

                    text: '添加审批人'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * documentApprovalPage.scale)
                    color: '#545454'
                    verticalAlignment: Text.AlignVCenter
                }

                CIndicatorDialog {
                    id:loadingOrg
                    messageText: os.i18n.ctr(qsTr("正在拉取数据..."))
                    messageTextPixelSize:gUtill.dpH2(32);
                }
                CDoodHeaderImage {
                    id: addApproverIcon

                    width: gUtill.dpW2(45 * documentApprovalPage.scale)
                    height: gUtill.dpH2(45 * documentApprovalPage.scale)
                    anchors{
                        top: addApproverDescription.bottom
                        topMargin: gUtill.dpH2(6 * documentApprovalPage.scale)
                        left: parent.left
                        leftMargin: gUtill.dpW2(15 * documentApprovalPage.scale)
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
                Text {
                    id: addApproverName

                    height: gUtill.dpH2(22 * documentApprovalPage.scale)
                    anchors{
                        left: parent.left
                        leftMargin: gUtill.dpW2(12.5 * documentApprovalPage.scale)
                        top: addApproverIcon.bottom
                        topMargin: gUtill.dpH2(6 * documentApprovalPage.scale)
                    }

                    text: selectedName
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * documentApprovalPage.scale)
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
                height: gUtill.dpH2(49 * documentApprovalPage.scale)
                anchors.bottom: parent.bottom

                enabled: contextTextArea.length > 0
                         && approvalDocumentList.count > 0
                         && selectedUserID !== ''

                color: enabled ? '#577EDD' : '#A2BCE8'

                Text {
                    id: submitText

                    height: gUtill.dpH2(22 * documentApprovalPage.scale)
                    anchors.centerIn: parent

                    text: '提交'
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(16 * documentApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    id: submitArea
                    anchors.fill: parent
                    onClicked: {
                        indicator.visible = true
                        submitButtonEnabled = false

                        var createUser = {}
                        createUser.userID = mainApp.currentID
                        createUser.userName = mainApp.currentName
                        createUser.userPhotoUrl = ''
                        var approver = {}
                        approver.userID = selectedUserID
                        approver.userName = selectedName
                        approver.userPhotoUrl = selectedPortrait
                        var docList = []
                        for (var i = 0; i < documentListModel.count; i++) {
                            console.log('item: ' + JSON.stringify(documentListModel.get(i)))
                            var item = {}
                            item.fileGUID = documentListModel.get(i).fileGUID
                            item.fileName = documentListModel.get(i).fileName
                            item.filePage = documentListModel.get(i).filePage
                            item.fileOverTime = documentListModel.get(i).fileOverTime
                            item.fileType = documentListModel.get(i).fileType
                            docList.push(item)
                        }
                        ApprovalRequest.addNewApprovalEvent(7,
                            createUser,
                            approver,
                            approvalDescriptionContent.text,
                            docList,
                            function (ret) {
                                indicator.visible = false
                                submitButtonEnabled = true

                                try {
                                    var obj = JSON.parse(ret)
                                }
                                catch (err) {
                                    gToast.requestToast("发送失败","","");
                                    return;
                                }

                                if (obj.code === 1) {
                                    gToast.requestToast("审批已提交","","");
                                    pageStack.pop()
                                }
                                else {
                                    gToast.requestToast("发送失败","","");
                                }
                            })
                    }
                }
            }

            Component {
                id: fillItemDelegate

                Rectangle {
                    id: fillItemBackground
                    width: parent.width
                    height: gUtill.dpH2(49 * documentApprovalPage.scale)
                    color: 'white'

                    Image {
                        id: fillFormatIcon

                        width: gUtill.dpW2(20 * documentApprovalPage.scale)
                        height: gUtill.dpH2(20 * documentApprovalPage.scale)
                        anchors.left: parent.left
                        anchors.leftMargin: gUtill.dpW2(16 * documentApprovalPage.scale)
                        anchors.verticalCenter: parent.verticalCenter
                        sourceSize.width: gUtill.dpW2(20 * documentApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * documentApprovalPage.scale)

                        source: getFillFormatIcon(fileType)
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: fillnameText

                        height: gUtill.dpH2(25 * documentApprovalPage.scale)
                        anchors {
                            left: fillFormatIcon.right
                            leftMargin: gUtill.dpW2(8 * documentApprovalPage.scale)
                            right: parent.right
                            rightMargin: gUtill.dpW2(18 * documentApprovalPage.scale)
                            verticalCenter: parent.verticalCenter
                        }

                        text: fileName
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(18 * documentApprovalPage.scale)
                        color: '#545454'
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Image {
                        id: fillSelectedIcon

                        width: gUtill.dpW2(21 * documentApprovalPage.scale)
                        height: gUtill.dpH2(21 * documentApprovalPage.scale)
                        anchors.right: parent.right
                        anchors.rightMargin: gUtill.dpW2(16 * documentApprovalPage.scale)
                        anchors.verticalCenter: parent.verticalCenter
                        sourceSize.width: gUtill.dpW2(21 * documentApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(21 * documentApprovalPage.scale)

                        source: 'qrc:/res/approval/ic_list_Delete Reveal.png'
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            id: deleteFileArea
                            anchors.fill: parent
                            onClicked: documentListModel.remove(index)
                        }
                    }

                    CLine {
                        width: parent.width
                        height: gUtill.dpH2(1 * documentApprovalPage.scale)
                        anchors.bottom: parent.bottom
                        color: '#DDDFEB'
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
        messageText: "当前审批尚未提交，直接返回，系统不保留您已录入的内容，请确认您的操作"
        acceptedButtonText: '<font color=\"#0076FF\">确认返回</font>'
        rejectButtonText: '<font color=\"#0076FF\">暂不返回</font>'
        onAccepted: pageStack.pop()
    }

    ListModel {
        id: documentListModel
        ListElement {
            fileType: '.doc'
            fileName: 'test.doc'
        }
    }

    function getFillFormatIcon(type) {
        if(type === '.doc'){
            return "qrc:/res/approval/ic_cloud_doc.png";
        }
        else if(type === '.exe') {
            return "qrc:/res/approval/ic_cloud_exe.png";
        }
        else if(type === '.pdf') {
            return "qrc:/res/approval/ic_cloud_pdf.png";
        }
        else {
            return "qrc:/res/approval/ic_cloud_exe.png"
        }
    }
}
