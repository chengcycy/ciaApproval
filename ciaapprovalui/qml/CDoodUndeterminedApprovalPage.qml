import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest

CPage{
    id: undeterminedApprovalPage

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
//            if (myTabView.currentIndex === 0) {
//                undeterminedList.loading = true
//                approvalManager.undeterminedApprovalModel.reset();
//            }
//            else if (myTabView.currentIndex === 1) {
//                determinedList.loading = true
//                approvalManager.determinedApprovalModel.reset();
//            }
            ApprovalRequest.selectNeedApprovalEvent(currentID,
                                                    myTabView.currentIndex,
                                                    onGetUndetermindList)
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
                height: gUtill.dpH2(110 * undeterminedApprovalPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * undeterminedApprovalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * undeterminedApprovalPage.scale)

                    text: qsTr('待我处理')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * undeterminedApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * undeterminedApprovalPage.scale)
                    height: gUtill.dpH2(22 * undeterminedApprovalPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * undeterminedApprovalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * undeterminedApprovalPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * undeterminedApprovalPage.scale)
                        height: gUtill.dpH2(20 * undeterminedApprovalPage.scale)
                        anchors.left: parent.left
                        anchors.top: parent.top

                        sourceSize.width: gUtill.dpW2(12 * undeterminedApprovalPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * undeterminedApprovalPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * undeterminedApprovalPage.scale)
                        anchors.top: backButtonIcon.top

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * undeterminedApprovalPage.scale)
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

                    width: gUtill.dpW2(34 * undeterminedApprovalPage.scale)
                    height: gUtill.dpH2(22 * undeterminedApprovalPage.scale)
                    anchors.right: parent.right
                    anchors.rightMargin: gUtill.dpW2(13 * undeterminedApprovalPage.scale)
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(34 * undeterminedApprovalPage.scale)

                    text: qsTr('编辑')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * undeterminedApprovalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignTop

                    visible: false
                }

                CLineEdit {
                    id: serachContactId

                    width: gUtill.dpW2(350 * undeterminedApprovalPage.scale)
                    height: gUtill.dpH2(34 * undeterminedApprovalPage.scale)
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(69 * undeterminedApprovalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(14 * undeterminedApprovalPage.scale)
                    inputMethodHints: Qt.ImhHiddenText

                    searchLabelEnabled: true
                    searchLabelLeftMargin: gUtill.dpW2(130 * undeterminedApprovalPage.scale)
                    searchLabelRightMargin: 0
                    searchLabelIcon: 'qrc:/res/approval/ic_search_nor.png'
                    placeholderText: qsTr("搜索")
                    placeholderTextItem.color: '#475883'
                    placeholderTextItem.font.family: 'PingFangSC-Regular'
                    placeholderTextItem.font.pixelSize: gUtill.dpH2(14 * undeterminedApprovalPage.scale)

                    //readOnly: true

                    backgroundComponent: Rectangle {
                        width: gUtill.dpW2(350 * undeterminedApprovalPage.scale)
                        height: gUtill.dpH2(34 * undeterminedApprovalPage.scale)
                        radius: gUtill.dpH2(5 * undeterminedApprovalPage.scale)
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

            CTabView {
                id: myTabView

                width: parent.width
                anchors.top: titleArea.bottom
                anchors.bottom: parent.bottom

                // to be continue
                tabBar: CDoodTabViewEnterStyle{
                    tabView: myTabView
                    tabHeight: gUtill.dpH2(40 * undeterminedApprovalPage.scale)
                    tabWidth: parent.width / 2
//                    textTitle.font.family: 'PingFangSC-Regular'
//                    textTitle.font.pixelSize: gUtill.dpH2(16 * undeterminedApprovalPage.scale)
                    highlightColor: '#577EDD'
                    commonColor: '#545454'

                    onTabClick: {
                        if (myTabView.currentIndex === 0) {
                            //approvalManager.undeterminedApprovalModel.reset();
                            undeterminedList.loading = true
                        }
                        else if (myTabView.currentIndex === 1) {
                            //approvalManager.determinedApprovalModel.reset();
                            determinedList.loading = true
                        }
                        approvalManager.getUndetermindApprovalList(userProfileManager.id, myTabView.currentIndex)
                    }
                }

                CTab {
                    title: undeterminedApprovalModel.count === 0
                           ? qsTr("待我审批")
                           : qsTr("待我审批（" + undeterminedApprovalModel.count + "）")
                    CDoodApprovalListView {
                        id: undeterminedList
                        anchors.fill: parent
                        model: undeterminedApprovalModel
                        buttonVisible: true
                        parentId: undeterminedApprovalPage
                        listType: 3
                    }
                }

                CTab {
                    title: qsTr("我已审批")
                    CDoodApprovalListView {
                        id: determinedList
                        anchors.fill: parent
                        model: determinedApprovalModel
                        listType: 4
                    }
                }
            }
        }
    }

    ListModel {
        id: undeterminedApprovalModel
        ListElement {
            approvalID: 1
            targetName: '1'
            portrait: '1'
            approvalType: 1
            approvalStatus: 1
            time: '1'
        }
    }

    ListModel {
        id: determinedApprovalModel
        ListElement {
            approvalID: 1
            targetName: '1'
            portrait: '1'
            approvalType: 1
            approvalStatus: 1
            time: '1'
        }
    }

    function onGetUndetermindList(ret) {
        var obj = JSON.parse(ret)
        undeterminedApprovalModel.clear()
        if (obj.code === 1) {
            for (var i = 0; i < obj.result.length; i++) {
                var item = {};
                item.approvalID = obj.result[i].eventID
                item.targetName = obj.result[i].eventCreateUserInfo.userName
                item.portrait = obj.result[i].eventCreateUserInfo.userPhotoUrl
                item.approvalType = obj.result[i].eventApprovalType
                item.approvalStatus = obj.result[i].eventApprovalStatus
                item.time = Qt.formatDateTime(new Date(obj.result[i].eventApprovalEndTime).toString('MM/dd  hh:mm:ss'))
                console.log(obj.result[i].eventApprovalEndTime + item.time)
                undeterminedApprovalModel.append(item)
            }
        }
    }
}
