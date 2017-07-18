import QtQuick 2.0
import com.syberos.basewidgets 2.0
import 'CDoodApprovalRequest.js' as ApprovalRequest
import "../"

CPage{
    id: approvalPage

    property real scale: 1.92

    statusBarHoldEnabled: false
    Component.onCompleted: {
        //设置是否显示状态栏，应与statusBarHoldItemEnabled属性一致
        gScreenInfo.setStatusBar(true);

        //设置状态栏样式，取值为"black"，"white"，"transwhite"和"transblack"
        gScreenInfo.setStatusBarStyle("transwhite");

//        approvalManager.undeterminedApprovalModel.reset();
//        approvalManager.getUndetermindApprovalList(userProfileManager.id, 0)
        ApprovalRequest.selectNeedApprovalEvent(currentID, 0,
                                                onGetUndetermindListCount)
    }
//    onStatusChanged: {
//        if (status === CPageStatus.WillShow) {
//            approvalManager.undeterminedApprovalModel.reset();
//            approvalManager.getUndetermindApprovalList(userProfileManager.id, 0)
//        }
//    }

//    Connections {
//        target: approvalManager
//        onUserOutAuthResult: {
//            if (type === 0) {
//                return;
//            }

//            if (trustLevel === 0) {
//                pageStack.push(Qt.resolvedUrl('CDoodDocumentApprovalPage.qml'));
//            }
//            else {
//                if (trustLevel === -2) {
//                    alertDlg.messageText = "验证失败，请检查网络"
//                }
//                else {
//                    alertDlg.messageText = "您目前无权在移动端使用公文审批服务"
//                }
//                alertDlg.show()
//            }
//        }
//    }

    contentAreaItem: Item {
        anchors.fill: parent

        Rectangle {
            id: backgroundArea
            anchors.fill: parent
            color: '#F7F7F6'

            Rectangle {
                id: titleArea

                width: parent.width
                height: gUtill.dpH2(184 * approvalPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * approvalPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * approvalPage.scale)

                    text: qsTr('审批')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * approvalPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * approvalPage.scale)
                    height: gUtill.dpH2(22 * approvalPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * approvalPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * approvalPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * approvalPage.scale)
                        height: gUtill.dpH2(20 * approvalPage.scale)
                        anchors.left: parent.left
                        anchors.top: parent.top

                        sourceSize.width: gUtill.dpW2(12 * approvalPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * approvalPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * approvalPage.scale)
                        anchors.top: backButtonIcon.top

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * approvalPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: pageStack.pop();
                    }
                }

                Rectangle {
                    id: buttonUndetermined

                    width: gUtill.dpW2(53 * approvalPage.scale)
                    height: gUtill.dpH2(74 * approvalPage.scale)
                    anchors{
                        bottom: parent.bottom
                        bottomMargin: gUtill.dpH2(26 * approvalPage.scale)
                        left: parent.left
                        leftMargin: parent.width / 4 -  width / 2
                    }

                    color: 'transparent'

                    Image {
                        id: undeterminedButtonIcon

                        width: gUtill.dpW2(50 * approvalPage.scale)
                        height: gUtill.dpH2(50 * approvalPage.scale)
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        sourceSize.width: gUtill.dpW2(50 * approvalPage.scale)
                        sourceSize.height: gUtill.dpH2(50 * approvalPage.scale)

                        source: 'qrc:/res/approval/ic_works_examination_handle.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Rectangle {
                        id: unreadIcon
                        property int count: 0
                        width: gUtill.dpW2(15 * approvalPage.scale)
                        height: gUtill.dpH2(15 * approvalPage.scale)
                        anchors.top: parent.top
                        anchors.right: parent.right
                        radius: width / 2
                        color: '#FF6A29'
                        visible: count !== 0
                        Text {
                            anchors.centerIn: parent

                            text: parent.count > 99 ? 99 : parent.count
                            font.family: '.HelveticaNeueDeskInterface-Regular'
                            font.pixelSize: gUtill.dpH2(11 * approvalPage.scale)
                            color: 'white'
                        }
                    }

                    Text {
                        id: undeterminedButtonText

                        height: gUtill.dpH2(18 * approvalPage.scale)
                        anchors.top: undeterminedButtonIcon.bottom
                        anchors.topMargin: gUtill.dpH2(6 * approvalPage.scale)
                        anchors.horizontalCenter: undeterminedButtonIcon.horizontalCenter

                        text: qsTr('待我处理')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(13 * approvalPage.scale)
                        color: 'white'
                        verticalAlignment: Qt.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaUndetermined
                        anchors.fill: parent
                        onClicked: pageStack.push(Qt.resolvedUrl('CDoodUndeterminedApprovalPage.qml'));
                    }
                }

                Rectangle {
                    id: buttonOrigin

                    width: gUtill.dpW2(53 * approvalPage.scale)
                    height: gUtill.dpH2(74 * approvalPage.scale)
                    anchors{
                        bottom: parent.bottom
                        bottomMargin: gUtill.dpH2(26 * approvalPage.scale)
                        right: parent.right
                        rightMargin: parent.width / 4 -  width / 2
                    }

                    color: 'transparent'

                    Image {
                        id: originButtonIcon

                        width: gUtill.dpW2(50 * approvalPage.scale)
                        height: gUtill.dpH2(50 * approvalPage.scale)
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        sourceSize.width: gUtill.dpW2(50 * approvalPage.scale)
                        sourceSize.height: gUtill.dpH2(50 * approvalPage.scale)

                        source: 'qrc:/res/approval/ic_works_examination_originate.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: originButtonText

                        height: gUtill.dpH2(18 * approvalPage.scale)
                        anchors.top: originButtonIcon.bottom
                        anchors.topMargin: gUtill.dpH2(6 * approvalPage.scale)
                        anchors.horizontalCenter: originButtonIcon.horizontalCenter

                        text: qsTr('我发起的')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(13 * approvalPage.scale)
                        color: 'white'
                        verticalAlignment: Qt.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaOrigin
                        anchors.fill: parent
                        onClicked: pageStack.push(Qt.resolvedUrl('CDoodInitiatedApprovalPage.qml'));
                    }
                }
            }
            GridView {
                id: approvalTable

                width: parent.width
                height: gUtill.dpH2(327 * approvalPage.scale)


                cellWidth: width / 4
                cellHeight: gUtill.dpH2(100 * approvalPage.scale)

                header: approvalTableHeader
                delegate: approvalDelegate
                model: approvalModel

                clip: true
                interactive: false

                anchors.top: titleArea.bottom

                Component.onCompleted: {
                    headerItem.text = '审批模板'
                }
            }

            GridView {
                id: documentApprovalTable

                width: parent.width
                height: gUtill.dpH2(127 * approvalPage.scale)
                anchors.top: approvalTable.bottom

                cellWidth: width / 4
                cellHeight: gUtill.dpH2(100 * approvalPage.scale)

                header: approvalTableHeader
                delegate: approvalDelegate
                model: documentApprovalModel

                clip: true
                interactive: false
                visible: false

                Component.onCompleted: {
                    headerItem.text = '审批管理'
                }
            }

            Component {
                id: approvalTableHeader

                Rectangle {
                    id: approvalTableHeaderArea

                    property alias text: approvalTableHeaderText.text

                    width: parent.width
                    height: gUtill.dpH2(27 * approvalPage.scale)

                    color: '#F2F2F5'

                    Text {
                        id: approvalTableHeaderText

                        height: gUtill.dpH2(18 * approvalPage.scale)
                        anchors {
                            left: parent.left
                            leftMargin: gUtill.dpW2(15 * approvalPage.scale)
                            top: parent.top
                            topMargin: gUtill.dpH2(3 * approvalPage.scale)
                        }

                        text: qsTr('间隙标题')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(13 * approvalPage.scale)
                        color: '#394871'
                        verticalAlignment: Qt.AlignVCenter
                    }
                }
            }

            Component {
                id: approvalDelegate

                Item {
                    id: approvalTableDelegateArea

                    width: approvalTable.width / 4
                    height: gUtill.dpH2(100 * approvalPage.scale)

                    Rectangle {
                        id: delegateButton

                        width: delegateText.contentWidth
                        height: gUtill.dpH2(68 * approvalPage.scale)
                        anchors.top: parent.top
                        anchors.topMargin: gUtill.dpH2(20 * approvalPage.scale)
                        anchors.horizontalCenter: parent.horizontalCenter

                        color: 'transparent'

                        Image {
                            id: delegateIcon

                            width: gUtill.dpW2(42 * approvalPage.scale)
                            height: gUtill.dpH2(42 * approvalPage.scale)
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: gUtill.dpW2(42 * approvalPage.scale)
                            sourceSize.height: gUtill.dpH2(42 * approvalPage.scale)

                            source: icon
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            id: delegateText

                            height: gUtill.dpH2(18 * approvalPage.scale)
                            anchors.top: delegateIcon.bottom
                            anchors.topMargin: gUtill.dpH2(8 * approvalPage.scale)

                            text: name
                            font.family: 'PingFangSC-Regular'
                            font.pixelSize: gUtill.dpH2(13 * approvalPage.scale)
                            color: '#545454'
                            verticalAlignment: Qt.AlignVCenter
                        }

                        MouseArea {
                            id: mouseareaDelegate
                            anchors.fill: parent
                            onClicked: {
                                if (name === '公文审批') {
                                    ApprovalRequest.userOutAuth(userProfileManager.id,
                                                                onAuthResult)
                                    return;
                                }
                                else if (name === '出差') {
                                    pageStack.push(Qt.resolvedUrl('CDoodBusinessTripApproval.qml'));
                                    return;
                                }
                                else if (name === '已归档审批') {

                                }
                                else {
                                    pageStack.push(Qt.resolvedUrl('CDoodGeneralApprovalPage.qml'), {approvalType: index})
                                    console.log(index)
                                    return
                                }
                            }
                        }
                    }
                }
            }

            ListModel {
                id: approvalModel

                ListElement {
                    name: "通用"
                    icon: "qrc:/res/approval/ic_works_examination_currency.png"
                }
                ListElement {
                    name: "报销"
                    icon: "qrc:/res/approval/ic_works_examination_expense.png"
                }
                ListElement {
                    name: "请假"
                    icon: "qrc:/res/approval/ic_works_examination_absence.png"
                }
                ListElement {
                    name: "出差"
                    icon: "qrc:/res/approval/ic_works_examination_business trip.png"
                }
                ListElement {
                    name: "外出"
                    icon: "qrc:/res/approval/ic_works_examination_go out.png"
                }
                ListElement {
                    name: "采购"
                    icon: "qrc:/res/approval/ic_works_examination_purchase.png"
                }
                ListElement {
                    name: "转正"
                    icon: "qrc:/res/approval/ic_works_examination_promotion.png"
                }
//                ListElement {
//                    name: "调休"
//                    icon: "qrc:/res/approval/ic_works_examination_Rest.png"
//                }
                ListElement {
                    name: "公文审批"
                    icon: "qrc:/res/approval/ic_works_Shape.png"
                }
            }

            ListModel {
                id: documentApprovalModel

                ListElement {
                    name: "已归档审批"
                    icon: "qrc:/res/approval/ic_works_archived.png"
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
            pageStack.push(Qt.resolvedUrl('CDoodDocumentApprovalPage.qml'));
        }
        else {
            if (obj.code !== 200) {
                alertDlg.messageText = "通信失败，请检查网络"
            }
            else {
                alertDlg.messageText = "您目前无权在移动端使用公文审批服务"
            }
            alertDlg.show()
        }
    }

    function onGetUndetermindListCount(ret) {
        var obj = JSON.parse(ret)
        if (obj.code === 1) {
            unreadIcon.count = obj.result.length
        }
    }
}
