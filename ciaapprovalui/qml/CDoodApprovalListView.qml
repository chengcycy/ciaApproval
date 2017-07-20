import QtQuick 2.0
import com.syberos.basewidgets 2.0
import '../'

Item {
    id: approvalListView

    property real scale: 1.92
    property var model
    property bool buttonVisible: false
    property int listType: 0    // 1为我发起的，3为待我审批，4为我已审批
    property bool loading
    property var parentId
    property var typeList: [qsTr("通用审批"),qsTr("报销审批"),qsTr("请假审批"),qsTr("出差审批"),qsTr("外出审批"),qsTr("采购审批"),qsTr("转正审批")/*,qsTr("调休审批")*/,qsTr("公文审批"),qsTr("出差审批")]

//    Component.onCompleted: {
//        approvalListView.loading = true
//    }

//    Connections {
//        target: approvalManager
//        onGetApprovalListResult: {
//            if (type === listType) {
//                approvalListView.loading = false
//                if(!result) {
//                    gToast.requestToast(qsTr("获取失败"), "", "")
//                }
//            }
//        }
//    }

    onLoadingChanged: {
        if (loading) {
            loadIndicator.show()
        }
        else {
            loadIndicator.hide()
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: '#F7F7F6'

        ListView {
            id: listview

            anchors.fill: parent

            delegate: delegateComponent
            model: approvalListView.model
            clip: true
        }
    }

    Component {
        id: delegateComponent

        Rectangle {
            id: listItem
            width: parent.width
            height: gUtill.dpH2(69 * approvalListView.scale)
            color: 'white'

            CDoodHeaderImage {
                id: approverPortrait
                width: gUtill.dpW2(45 * approvalListView.scale)
                height: gUtill.dpH2(45 * approvalListView.scale)
                anchors{
                    left: parent.left
                    leftMargin: gUtill.dpW2(13.5 * approvalListView.scale)
                    verticalCenter: parent.verticalCenter
                }
                iconSource: setIcon('1', portrait)
            }

            Text {
                id: approvalName

                height: gUtill.dpH2(25 * approvalListView.scale)
                anchors {
                    left: approverPortrait.right
                    leftMargin: gUtill.dpW2(9.5 * approvalListView.scale)
                    top: parent.top
                    topMargin: gUtill.dpH2(13.5 * approvalListView.scale)
                    right: approvalStatusFlagIcon.left
                }

                text: targetName + '的' + typeList[approvalType]
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(18 * approvalListView.scale)
                color: '#545454'
                verticalAlignment: Qt.AlignVCenter
                elide: Text.ElideRight
            }

            Text {
                id: approvalStatusText

                height: gUtill.dpH2(17 * approvalListView.scale)
                anchors {
                    left: approvalName.left
                    top: approvalName.bottom
                }

                text: getStatusString(approvalStatus)
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(12.5 * approvalListView.scale)
                color: getStatusStringColor(approvalStatus)
                verticalAlignment: Qt.AlignVCenter
            }

            Text {
                id: approvalTime

                width: gUtill.dpW2(75 * approvalListView.scale)
                height: gUtill.dpH2(14 * approvalListView.scale)
                anchors {
                    right: parent.right
                    rightMargin: gUtill.dpW2(13 * approvalListView.scale)
                    bottom: parent.bottom
                    bottomMargin: gUtill.dpH2(15.5 * approvalListView.scale)
                }

                text: time
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(10 * approvalListView.scale)
                color: '#999999'
                verticalAlignment: Qt.AlignVCenter
            }

            Image {
                id: approvalStatusFlagIcon

                width: gUtill.dpW2(20 * approvalListView.scale)
                height: gUtill.dpH2(20 * approvalListView.scale)
                anchors.top: parent.top
                anchors.right: parent.right
                sourceSize.width: gUtill.dpW2(20 * approvalListView.scale)
                sourceSize.height: gUtill.dpH2(20 * approvalListView.scale)

                source: getStatusFlagIcon(approvalStatus)
                fillMode: Image.PreserveAspectFit
            }

            CLine {
                id: splitLine
                height: gUtill.dpH2(0.5 * approvalListView.scale)
                anchors {
                    left: parent.left
                    leftMargin: gUtill.dpW2(12 * approvalListView.scale)
                    right: parent.right
                    bottom: parent.bottom
                }
                color: '#DCDCDC'
            }

            MouseArea {
                id: mouseareaDelegate
                anchors.fill: parent
                onClicked: {//undeterminedApprovalPage
                    approvalManager.setDetailItem(approvalID,
                                                  approvalListView.listType)
                    pageStack.push(Qt.resolvedUrl('CDoodApprovalDetailsPage.qml'), {
                                       buttonVisible: approvalListView.buttonVisible,
                                       parentId: approvalListView.parentId
                                   });
                }
            }
        }
    }

//    CCircularIndicator {
//        id: loadIndicator
//        anchors.centerIn: parent
//        visible: approvalListView.isLoading
//    }
    CIndicatorDialog {
        id: loadIndicator
        messageText: "读取中..."
        visible: approvalListView.loading
        onBackKeyReleased: hide()
    }

    function getStatusString(type) {
        if(type === -1){
            return "驳回";
        }
        else if(type === 0) {
            return "提交申请";
        }
        else if(type === 1) {
            if (approvalListView.listType === 4) {
                return "已转批";
            }
            else {
                return "待审批";
            }
        }
        else if(type === 2) {
            return "已同意";
        }
        else {
            return "已转批";
        }
    }

    function getStatusStringColor(type) {
        if(type === -1){
            return "#D95666";
        }
        else if(type === 2) {
            return "#999999";
        }
        else {
            return "#E8A942";
        }
    }

    function getStatusFlagIcon(type) {
        if(type === -1){
            return "qrc:/res/approval/up Corner_reject.png";
        }
        else if(type === 2) {
            return "qrc:/res/approval/up Corner_pass.png";
        }
        else {
            return "qrc:/res/approval/up Corner_unaudited.png";
        }
    }
}
