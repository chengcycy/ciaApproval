import QtQuick 2.0
import com.syberos.basewidgets 2.0

CPage{
    id: approvalDetailPage

    property real scale: 1.92
    property bool buttonVisible: false
    property var typeList: [qsTr("通用审批"),qsTr("报销审批"),qsTr("请假审批"),qsTr("出差审批"),qsTr("外出审批"),qsTr("采购审批"),qsTr("转正审批")/*,qsTr("调休审批")*/,qsTr("公文审批"),qsTr("出差审批")]
    property var parentId
    property var currentApproval: ({})

    statusBarHoldEnabled: false
    Component.onCompleted: {
        //设置是否显示状态栏，应与statusBarHoldItemEnabled属性一致
        gScreenInfo.setStatusBar(true);

        //设置状态栏样式，取值为"black"，"white"，"transwhite"和"transblack"
        gScreenInfo.setStatusBarStyle("transwhite");

        approvalAttachmentModel.clear()
        approvalStatusModel.clear()
        loadData()
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
                height: gUtill.dpH2(64 * approvalDetailPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * approvalDetailPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * approvalDetailPage.scale)

                    text: typeList[currentApproval.approvalType]
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * approvalDetailPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * approvalDetailPage.scale)
                    height: gUtill.dpH2(22 * approvalDetailPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * approvalDetailPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * approvalDetailPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * approvalDetailPage.scale)
                        height: gUtill.dpH2(20 * approvalDetailPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * approvalDetailPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * approvalDetailPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * approvalDetailPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * approvalDetailPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: pageStack.pop();
                    }
                }
            }

            Flickable {
                id: contentFlick
                width: parent.width
                anchors.top: titleArea.bottom
                anchors.bottom: approvalDetailPage.buttonVisible
                                ? buttonArea.top : parent.bottom
                contentHeight: getContentHeight()
                boundsBehavior: Flickable.StopAtBounds
                clip:true

                Component.onCompleted: {
                    console.log(contentHeight + ' ' + contentFlick.height)
                    console.log(parent.height + ' ' + titleArea.height + ' ' + buttonArea.height)
                    console.log(anchors.bottom)
                }

                function getHeight() {
                    if (approvalDetailPage.buttonVisible) {
                        return parent.height - titleArea.height - buttonArea.height
                    }
                    else {
                        return parent.height - titleArea.height
                    }
                }

                function getContentHeight() {
                    if (approvalDetailPage.buttonVisible) {
                        return gUtill.dpH2(164 * approvalDetailPage.scale)
                                + approvalAttachmentList.height
                                + approvedStatusList.height
                    }
                    else {
                        return gUtill.dpH2(223 * approvalDetailPage.scale)
                                + approvalAttachmentList.height
                                + approvedStatusList.height
                    }
                }

                Rectangle {
                    id: outlineArea
                    width: parent.width
                    height: gUtill.dpH2(69 * approvalDetailPage.scale)
                    anchors.top: parent.top
                    color: 'white'

                    CDoodHeaderImage {
                        id: approverPortrait
                        width: gUtill.dpW2(45 * approvalDetailPage.scale)
                        height: gUtill.dpH2(45 * approvalDetailPage.scale)
                        anchors{
                            left: parent.left
                            leftMargin: gUtill.dpW2(12.5 * approvalDetailPage.scale)
                            verticalCenter: parent.verticalCenter
                        }
                        iconSource: setIcon('1', currentApproval.portrait)
                    }

                    Text {
                        id: approvalName

                        height: gUtill.dpH2(25 * approvalDetailPage.scale)
                        anchors {
                            left: approverPortrait.right
                            leftMargin: gUtill.dpW2(10.5 * approvalDetailPage.scale)
                            top: parent.top
                            topMargin: gUtill.dpH2(13 * approvalDetailPage.scale)
                            right: approvalStatusFlagIcon.left
                        }

                        text: currentApproval.targetName + '的'
                              + typeList[currentApproval.approvalType] +'申请'
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(18 * approvalDetailPage.scale)
                        color: '#545454'
                        verticalAlignment: Qt.AlignVCenter
                        elide: Text.ElideRight
                    }

                    Text {
                        id: approvalID

                        //width: gUtill.dpW2(75 * approvalDetailPage.scale)
                        height: gUtill.dpH2(17 * approvalDetailPage.scale)
                        anchors {
                            left: approvalName.left
                            top: approvalName.bottom
                        }

                        text: '编号：' + currentApproval.approvalID
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(12.5 * approvalDetailPage.scale)
                        color: '#999999'
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Text {
                        id: approvalStatus

                        height: gUtill.dpH2(17 * approvalDetailPage.scale)
                        anchors {
                            top: approvalID.top
                            right: parent.right
                            rightMargin: gUtill.dpW2(13 * approvalDetailPage.scale)
                        }

                        text: getStatusString(currentApproval.approvalStatus)
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(12.5 * approvalDetailPage.scale)
                        color: getStatusStringColor(currentApproval.approvalStatus)
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Image {
                        id: approvalStatusFlagIcon

                        width: gUtill.dpW2(20 * approvalDetailPage.scale)
                        height: gUtill.dpH2(20 * approvalDetailPage.scale)
                        anchors.top: parent.top
                        anchors.right: parent.right
                        sourceSize.width: gUtill.dpW2(20 * approvalDetailPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * approvalDetailPage.scale)

                        source: getStatusFlagIcon(currentApproval.approvalStatus)
                        fillMode: Image.PreserveAspectFit
                    }

                    CLine {
                        width: parent.width
                        height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                        anchors.bottom: parent.bottom
                        color: '#DDDFEB'
                    }
                }

                Rectangle {
                    id: approvalContentArea
                    width: parent.width
                    height: gUtill.dpH2(75 * approvalDetailPage.scale)
                    anchors.top: outlineArea.bottom
                    anchors.topMargin: gUtill.dpH2(10 * approvalDetailPage.scale)
                    color: 'white'

                    CLine {
                        width: parent.width
                        height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                        anchors.top: parent.top
                        color: '#DDDFEB'
                    }

                    Rectangle {
                        width: gUtill.dpW2(4 * approvalDetailPage.scale)
                        height: gUtill.dpH2(17 * approvalDetailPage.scale)
                        anchors{
                            left: parent.left
                            leftMargin: gUtill.dpW2(15 * approvalDetailPage.scale)
                            top: parent.top
                            topMargin: gUtill.dpH2(16 * approvalDetailPage.scale)
                        }
                        color: '#F46F80'
                    }

                    Text {
                        id: approvalContentTip
                        width: gUtill.dpW2(63 * approvalDetailPage.scale)
                        height: gUtill.dpH2(22 * approvalDetailPage.scale)
                        anchors{
                            left: parent.left
                            leftMargin: gUtill.dpW2(27.5 * approvalDetailPage.scale)
                            top: parent.top
                            topMargin: gUtill.dpH2(16 * approvalDetailPage.scale)
                        }

                        text: '审批内容'
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(16 * approvalDetailPage.scale)
                        color: '#545454'
                        //verticalAlignment: Qt.AlignBottom
                    }

                    CTextArea {
                        id: approvalContentText
                        anchors{
                            top: parent.top
                            topMargin: gUtill.dpH2(16 * approvalDetailPage.scale)
                            left: approvalContentTip.right
                            leftMargin: gUtill.dpW2(19 * approvalDetailPage.scale)
                            right: parent.right
                            rightMargin: gUtill.dpW2(13 * approvalDetailPage.scale)
                            bottom: parent.bottom
                            bottomMargin: gUtill.dpH2(13 * approvalDetailPage.scale)
                        }

                        text: parseContent()
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(16 * approvalDetailPage.scale)
                        textColor: '#577EDD'
                        readOnly: true
                        flickableInteractive: contentHeight > height

                        function parseContent() {
                            if (currentApproval.approvalType === 8) {
                                var json = JSON.parse(currentApproval.content)
                                var content = '出差地点：' + json.pos_change_to
                                content += '，开始时间：' + json.begin_date
                                content += '，结束时间：' + json.end_date
                                if (json.outReaSon.length > 0)
                                    content += '，出差原因：' + json.outReaSon
                                return content
                            }
                            else {
                                return currentApproval.content
                            }
                        }
                    }

                    CLine {
                        width: parent.width
                        height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                        anchors.bottom: parent.bottom
                        color: '#DDDFEB'
                    }
                }

                Rectangle {
                    id: approvalAttachmentHeader
                    width: parent.width
                    height: gUtill.dpH2(49 * approvalDetailPage.scale)
                    anchors.top: approvalContentArea.bottom
                    anchors.topMargin: gUtill.dpH2(10 * approvalDetailPage.scale)
                    color: 'white'

                    visible: approvalAttachmentList.visible

                    CLine {
                        width: parent.width
                        height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                        anchors.top: parent.top
                        color: '#DDDFEB'
                    }

                    Rectangle {
                        width: gUtill.dpW2(4 * approvalDetailPage.scale)
                        height: gUtill.dpH2(17 * approvalDetailPage.scale)
                        anchors{
                            left: parent.left
                            leftMargin: gUtill.dpW2(15 * approvalDetailPage.scale)
                            top: parent.top
                            topMargin: gUtill.dpH2(16 * approvalDetailPage.scale)
                        }
                        color: '#F46F80'
                    }

                    Text {
                        id: approvalAttachmentTip
                        width: gUtill.dpW2(63 * approvalDetailPage.scale)
                        height: gUtill.dpH2(22 * approvalDetailPage.scale)
                        anchors{
                            left: parent.left
                            leftMargin: gUtill.dpW2(27.5 * approvalDetailPage.scale)
                            top: parent.top
                            topMargin: gUtill.dpH2(16 * approvalDetailPage.scale)
                        }

                        text: '公文文件'
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(16 * approvalDetailPage.scale)
                        color: '#545454'
                    }

                    CLine {
                        width: parent.width
                        height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                        anchors.bottom: parent.bottom
                        color: '#DDDFEB'
                    }
                }

                ListView {
                    id: approvalAttachmentList

                    width: parent.width
                    height: gUtill.dpH2(count * 49 * approvalDetailPage.scale)
                    anchors.top: approvalAttachmentHeader.bottom
                    model: approvalAttachmentModel
                    delegate: fileItemDelegate
                    clip: true
                    interactive: false

                    visible: currentApproval.approvalType === 7 && count > 0
                }

                ListView {
                    id: approvedStatusList
                    width: parent.width
                    height: gUtill.dpH2(count * 70 * approvalDetailPage.scale)
                    anchors.top: approvalAttachmentList.visible ?
                                     approvalAttachmentList.bottom :
                                     approvalContentArea.bottom
                    anchors.topMargin: gUtill.dpH2(10 * approvalDetailPage.scale)
                    model: approvalStatusModel
                    delegate: statusItemDelegate
                    clip: true
                    interactive: false

                    CLine {
                        width: parent.width
                        height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                        anchors.top: parent.top
                        color: '#DDDFEB'
                    }
                }
            }

            Rectangle {
                id: buttonArea

                width: parent.width
                height: gUtill.dpH2(49 * approvalDetailPage.scale)
                anchors.bottom: parent.bottom
                visible: approvalDetailPage.buttonVisible

                Row {
                    Repeater {
                        property var listGeneral: ['驳回', '同意', '转批']
                        property var listDoc: ['驳回', '同意']
                        model: currentApproval.approvalType === 7 ? listDoc : listGeneral
                        Rectangle {
                            width: currentApproval.approvalType === 7 ? buttonArea.width / 2
                                                                    : buttonArea.width / 3
                            height: buttonArea.height
                            color: 'white'

                            CLine {
                                height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                                anchors.top: parent.top
                                color: '#E3E3E3'
                            }

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                font.family: 'PingFangSC-Regular'
                                font.pixelSize: gUtill.dpH2(16 * approvalDetailPage.scale)
                                color: '#577EDD'
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (modelData == '驳回') {
                                        pageStack.push(
                                            Qt.resolvedUrl('CDoodApprovalRejectPage.qml'),
                                            {undeterminedApprovalPageId: parentId,
                                                approvalID: currentApproval.approvalID})
                                    }
                                    else if (modelData == '同意') {
                                        pageStack.push(
                                            Qt.resolvedUrl('CDoodApprovalPassPage.qml'),
                                            {undeterminedApprovalPageId: parentId,
                                                approvalID: currentApproval.approvalID})
                                    }
                                    else if (modelData == '转批') {
                                        var component = pageStack.push(
                                            Qt.resolvedUrl('CDoodApprovalTranspondPage.qml'),
                                            {undeterminedApprovalPageId: parentId,
                                                approvalID: currentApproval.approvalID})

                                        component.callback.connect(function(ret){
                                            var obj = JSON.parse(ret)
                                            if (obj.code === 1){
                                                currentApproval = obj;
                                                buttonVisible = false
                                            }
                                        });
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: fileItemDelegate

        Rectangle {
            id: fileItemBackground
            width: parent.width
            height: gUtill.dpH2(49 * approvalDetailPage.scale)
            color: 'white'

            Image {
                id: fileFormatIcon

                width: gUtill.dpW2(20 * approvalDetailPage.scale)
                height: gUtill.dpH2(20 * approvalDetailPage.scale)
                anchors.left: parent.left
                anchors.leftMargin: gUtill.dpW2(18 * approvalDetailPage.scale)
                anchors.verticalCenter: parent.verticalCenter
                sourceSize.width: gUtill.dpW2(20 * approvalDetailPage.scale)
                sourceSize.height: gUtill.dpH2(20 * approvalDetailPage.scale)

                source: getFileFormatIcon(fileType)
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: filenameText

                height: gUtill.dpH2(25 * approvalDetailPage.scale)
                anchors {
                    left: fileFormatIcon.right
                    leftMargin: gUtill.dpW2(8 * approvalDetailPage.scale)
                    right: parent.right
                    rightMargin: gUtill.dpW2(18 * approvalDetailPage.scale)
                    verticalCenter: parent.verticalCenter
                }

                text: fileName
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(18 * approvalDetailPage.scale)
                color: '#545454'
                verticalAlignment: Qt.AlignVCenter
            }

            CLine {
                width: parent.width
                height: gUtill.dpH2(1 * approvalDetailPage.scale)
                anchors.bottom: parent.bottom
                color: '#DDDFEB'
            }

            MouseArea {
                id: fileArea
                anchors.fill: parent
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('CDoodDocumentDetailPage.qml'),
                                   {currentDoc: approvalAttachmentModel.get(index)})
                }
            }
        }
    }

    Component {
        id: statusItemDelegate

        Rectangle {
            id: listItem
            width: parent.width
            height: gUtill.dpH2(70 * approvalDetailPage.scale)
            color: 'white'

            CDoodHeaderImage {
                id: approverPortrait
                width: gUtill.dpW2(45 * approvalDetailPage.scale)
                height: gUtill.dpH2(45 * approvalDetailPage.scale)
                anchors{
                    left: parent.left
                    leftMargin: gUtill.dpW2(12.5 * approvalDetailPage.scale)
                    verticalCenter: parent.verticalCenter
                }
                iconSource: setIcon('1', '')
            }

            Text {
                id: approverNameText

                height: gUtill.dpH2(25 * approvalDetailPage.scale)
                anchors {
                    left: approverPortrait.right
                    leftMargin: gUtill.dpW2(10.5 * approvalDetailPage.scale)
                    top: parent.top
                    topMargin: gUtill.dpH2(13 * approvalDetailPage.scale)
                    right: approvalStatusFlagIcon.left
                }

                text: userName
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(18 * approvalDetailPage.scale)
                color: '#545454'
                verticalAlignment: Qt.AlignVCenter
                elide: Text.ElideRight
            }

            Text {
                id: approvalStatusDetail

                height: gUtill.dpH2(17 * approvalDetailPage.scale)
                anchors {
                    left: approverNameText.left
                    top: approverNameText.bottom
                    right: approvalTimeText.right
                }

                text: getStatusString(status, opinion)
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(12.5 * approvalDetailPage.scale)
                color: '#999999'
                verticalAlignment: Qt.AlignVCenter
                elide: Text.ElideRight
            }

            Text {
                id: approvalTimeText

                width: gUtill.dpW2(75 * approvalDetailPage.scale)
                height: gUtill.dpH2(14 * approvalDetailPage.scale)
                anchors {
                    top: parent.top
                    topMargin: gUtill.dpH2(20 * approvalDetailPage.scale)
                    right: parent.right
                    rightMargin: gUtill.dpW2(13 * approvalDetailPage.scale)
                }

                text: time
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(10 * approvalDetailPage.scale)
                color: '#999999'
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignRight
            }

            Image {
                id: approvalStatusFlagIcon

                width: gUtill.dpW2(20 * approvalDetailPage.scale)
                height: gUtill.dpH2(20 * approvalDetailPage.scale)
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                sourceSize.width: gUtill.dpW2(20 * approvalDetailPage.scale)
                sourceSize.height: gUtill.dpH2(20 * approvalDetailPage.scale)

                source: getStatusFlagBottomIcon(status)
                fillMode: Image.PreserveAspectFit
            }

            CLine {
                id: splitLine
                height: gUtill.dpH2(0.5 * approvalDetailPage.scale)
                anchors {
                    left: parent.left
                    leftMargin: gUtill.dpW2(12 * approvalDetailPage.scale)
                    right: parent.right
                    bottom: parent.bottom
                }
                color: '#DDDFEB'
            }

            MouseArea {
                id: statuItemArea
                anchors.fill: parent
                enabled: opinion.length > 0
                onClicked: {
                    contentDlg.content = opinion
                    contentDlg.show()
                }
            }
        }
    }

    CDoodPopWndLayer {
        id: contentDlg
        property string content: ""
        contentItemBackGroundOpacity:0.73
        contentItem: Rectangle {
            id: contentBackground
            width: parent.width - gUtill.dpW2(60 * approvalDetailPage.scale)
            height: contentText.contentHeight + gUtill.dpH2(60 * approvalDetailPage.scale)
            radius: 50
            color: gUiConst.getValue("CB1")
            Text {
                id: contentText
                anchors.fill: parent
                anchors.margins: gUtill.dpW2(30 * approvalDetailPage.scale)
                text: contentDlg.content
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(16 * approvalDetailPage.scale)
                wrapMode: Text.Wrap
            }
        }
        onBackKeyReleased: {
            contentDlg.hide();
        }
        onOutAreaClicked: {
            contentDlg.hide();
        }
    }

    CAlertDialog {
        id: alertDlg
        property string filename: ""
        titleText: "警告"
        messageText: "文件<font color=\"#0076FF\">“" + filename+ "”</font>与您的访问权限不符，已拒绝您的访问请求！"
        alertButtonText: "<font color=\"#0076FF\">确定</font>"
    }

    ListModel {
        id: approvalAttachmentModel
        ListElement {
            fileName: ''
            fileType: ''
        }
    }

    ListModel {
        id: approvalStatusModel
        ListElement {
            userName: ''
            time: ''
            status: 0
            opinion: ''
        }
    }

    function loadData() {
        console.log('currentApproval: '
                    + JSON.stringify(currentApproval))

        var arr = JSON.parse(currentApproval.attachmentsList);
        for (var i = 0; i < arr.length; i++) {
            console.log('approvalAttachmentModel: '
                        + JSON.stringify(arr[i]))
            var item = {};
            item.fileName = arr[i].attachmentName
            item.fileType = item.fileName.substring(item.fileName.lastIndexOf('.'))
            item.filePath = arr[i].attachmentPath
            item.pageSize = arr[i].attachmentPageSize
            approvalAttachmentModel.append(item)
        }

        arr = JSON.parse(currentApproval.statusList);
        for (var i = 0; i < arr.length; i++) {
            console.log('approvalStatusModel: '
                        + JSON.stringify(arr[i]))
            var item = {};
            item.userName = arr[i].eventApprovalUsersInfo[0].userName
            var time = arr[i].approvalTime
            if (time === 0) {
                item.time = '现在'
            }
            else {
                item.time = Qt.formatDateTime(new Date(), 'MM/dd  hh:mm:ss')
            }
            item.status = arr[i].approvalStatus
            item.opinion = arr[i].approvalOpinion
            approvalStatusModel.append(item)
        }
    }

    function getStatusString(type, opinion) {
        if(type === -1){
            if (opinion.length === 0) {
                return "驳回";
            }
            else {
                return "驳回：" + opinion;
            }
        }
        else if(type === 0) {
            return "提交申请";
        }
        else if(type === 1) {
            return "待审批";
        }
        else if(type === 2) {
            if (opinion.length === 0) {
                return "已同意";
            }
            else {
                return "已同意：" + opinion;
            }
        }
        else if(type === 3) {
            if (opinion.length === 0) {
                return "已转批";
            }
            else {
                return "已转批：" + opinion;
            }
        }
        else {
            return "";
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

    function getFileFormatIcon(type) {
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
            return "qrc:/res/approval/ic_cloud_exe.png";
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

    function getStatusFlagBottomIcon(type) {
        if(type === -1){
            return "qrc:/res/approval/down Corner_Reject.png";
        }
        else if(type === 0) {
            return "qrc:/res/approval/down Corner_applicant.png";
        }
        else if(type === 1){
            return "qrc:/res/approval/down Corner_unaudited.png";
        }
        else if(type === 2){
            return "qrc:/res/approval/down Corner_pass.png";
        }
        else if(type === 3){
            return "qrc:/res/approval/down Corner_unaudited.png";
        }
        else {
            return ""
        }
    }
}
