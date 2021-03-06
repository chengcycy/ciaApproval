import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: initiatedApprovalPage

    property real scale: 1.92

    statusBarHoldEnabled: false
    Component.onCompleted: {
        //设置是否显示状态栏，应与statusBarHoldItemEnabled属性一致
        gScreenInfo.setStatusBar(true);

        //设置状态栏样式，取值为"black"，"white"，"transwhite"和"transblack"
        gScreenInfo.setStatusBarStyle("transwhite");
    }
    onStatusChanged: {
        if (status === CPageStatus.WillShow) {
            initiatedApprovalModel.clear()
            initiatedApprovalList.loading = true
            ApprovalRequest.selectMeCreateApprovalEvent(mainApp.currentID, 0,
                                                        onGetInitiatedList)
        }
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
                height: gUtill.dpH2(110 * initiatedApprovalPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * initiatedApprovalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * initiatedApprovalPage.scale)

                    text: qsTr('我发起的')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * initiatedApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * initiatedApprovalPage.scale)
                    height: gUtill.dpH2(22 * initiatedApprovalPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * initiatedApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * initiatedApprovalPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * initiatedApprovalPage.scale)
                        height: gUtill.dpH2(20 * initiatedApprovalPage.scale)
                        anchors.left: parent.left
                        anchors.top: parent.top

                        sourceSize.width: gUtill.dpW2(12 * initiatedApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * initiatedApprovalPage.scale)
                        source: 'qrc:/res//approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * initiatedApprovalPage.scale)
                        anchors.top: backButtonIcon.top

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * initiatedApprovalPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: pageStack.pop();
                    }
                }

                Text {
                    id: editButton

                    width: gUtill.dpW2(34 * initiatedApprovalPage.scale)
                    height: gUtill.dpH2(22 * initiatedApprovalPage.scale)
                    anchors.right: parent.right
                    anchors.rightMargin: gUtill.dpW2(13 * initiatedApprovalPage.scale)
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(34 * initiatedApprovalPage.scale)

                    text: qsTr('编辑')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * initiatedApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignTop

                    visible: false
                }

                CLineEdit {
                    id: serachContactId

                    width: gUtill.dpW2(350 * initiatedApprovalPage.scale)//parent.width
                    height: gUtill.dpH2(34 * initiatedApprovalPage.scale)//parent.height
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(69 * initiatedApprovalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(14 * initiatedApprovalPage.scale)
                    inputMethodHints: Qt.ImhHiddenText

                    searchLabelEnabled: true
                    searchLabelLeftMargin: gUtill.dpW2(130 * initiatedApprovalPage.scale)
                    searchLabelRightMargin: 0
                    searchLabelIcon: 'qrc:/res//approval/ic_search_nor.png'
                    placeholderText: qsTr("搜索")
                    placeholderTextItem.color: '#475883'
                    placeholderTextItem.font.family: 'PingFangSC-Regular'
                    placeholderTextItem.font.pixelSize: gUtill.dpH2(14 * initiatedApprovalPage.scale)

                    //readOnly: true

                    backgroundComponent: Rectangle {
                        width: gUtill.dpW2(350 * initiatedApprovalPage.scale)
                        height: gUtill.dpH2(34 * initiatedApprovalPage.scale)
                        radius: gUtill.dpH2(5 * initiatedApprovalPage.scale)
                        color: '#2B385C'
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                             //pageStack.push('qrc:/qml/CDoodSearchContactPage.qml')
                        }
                    }
                }
            }

            CDoodApprovalListView {
                id: initiatedApprovalList
                width: parent.width
                anchors.top: titleArea.bottom
                anchors.bottom: parent.bottom
                model: initiatedApprovalModel
                loading: true
                listType: 1
            }
        }
    }

    ListModel {
        id: initiatedApprovalModel
        ListElement {
            approvalID: 0
            targetName: ''
            portrait: ''
            approvalType: 0
            approvalStatus: 0
            content: ''
            time: ''
            attachmentsList: ''
            statusList: ''
        }
    }

    function onGetInitiatedList(ret, index) {
        var obj = JSON.parse(ret)
        if (obj.code === 1) {
            for (var i = 0; i < obj.result.length; i++) {
                console.log('initiatedApprovalModel ' + JSON.stringify(obj.result[i]))
                var item = {};
                item.approvalID = obj.result[i].eventID
                item.targetName = obj.result[i].eventCreateUserInfo.userName
                item.portrait = obj.result[i].eventCreateUserInfo.userPhotoUrl
                item.approvalType = obj.result[i].eventApprovalType
                item.approvalStatus = obj.result[i].eventApprovalStatus
                item.content = obj.result[i].eventContent
                item.time = Qt.formatDateTime(new Date(obj.result[i].eventCreateTime), 'MM/dd  hh:mm:ss')
                item.attachmentsList = JSON.stringify(obj.result[i].attachmentTables)
                item.statusList = JSON.stringify(obj.result[i].eventApprovals)
                initiatedApprovalModel.append(item)
            }

            if (index === 0) {
                ApprovalRequest.selectMeCreateApprovalEvent(mainApp.currentID, 1,
                                                            onGetInitiatedList)
            }
            else if (index === 1) {
                initiatedApprovalList.loading = false
            }
        }
    }
}
