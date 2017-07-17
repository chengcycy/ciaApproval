import QtQuick 2.0
import com.syberos.basewidgets 2.0
import "../"

CPage{
    id: approvalDocumentListPage

    property real scale: 1.92

    statusBarHoldEnabled: false
    Component.onCompleted: {
        //设置是否显示状态栏，应与statusBarHoldItemEnabled属性一致
        gScreenInfo.setStatusBar(true);

        //设置状态栏样式，取值为"black"，"white"，"transwhite"和"transblack"
        gScreenInfo.setStatusBarStyle("transwhite");

        approvalManager.approvalDocumentsModel.reset()
    }

    Connections {
        target: approvalManager
        onCheckResult: {
            if (pass) {
                pageStack.pop()
            }
            else{
                alertDlg.filename = fillName
                alertDlg.show()
            }
        }
        onGetFilesListResult: {
            alertDlg.messageText = '您的权限不够，获取不到文件列表'
            alertDlg.show()
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
                height: gUtill.dpH2(110 * approvalDocumentListPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * approvalDocumentListPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * approvalDocumentListPage.scale)

                    text: qsTr('选择公文')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * approvalDocumentListPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: backButtonText.contentWidth
                    height: gUtill.dpH2(22 * approvalDocumentListPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * approvalDocumentListPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * approvalDocumentListPage.scale)
                    }

                    color: 'transparent'

                    Text {
                        id: backButtonText
                        anchors.fill: parent
                        text: qsTr('取消')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * approvalDocumentListPage.scale)
                        color: 'white'
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: mouseareaBack
                        anchors.fill: parent
                        onClicked: {
                            approvalManager.approvalDocumentsModel.reset()
                            pageStack.pop();
                        }
                    }
                }

                Text {
                    id: submitButton

                    width: gUtill.dpW2(34 * approvalDocumentListPage.scale)
                    height: gUtill.dpH2(22 * approvalDocumentListPage.scale)
                    anchors.right: parent.right
                    anchors.rightMargin: gUtill.dpW2(13 * approvalDocumentListPage.scale)
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(34 * approvalDocumentListPage.scale)

                    text: qsTr('确定')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * approvalDocumentListPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignTop

                    MouseArea {
                        id: mouseareaSubmit
                        anchors.fill: parent
                        onClicked: {
                            approvalManager.selectFiles()
                        }
                    }
                }

                CLineEdit {
                    id: serachContactId

                    width: gUtill.dpW2(350 * approvalDocumentListPage.scale)//parent.width
                    height: gUtill.dpH2(34 * approvalDocumentListPage.scale)//parent.height
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(69 * approvalDocumentListPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(14 * approvalDocumentListPage.scale)
                    inputMethodHints: Qt.ImhHiddenText

                    searchLabelEnabled: true
                    searchLabelLeftMargin: gUtill.dpW2(130 * approvalDocumentListPage.scale)
                    searchLabelRightMargin: 0
                    searchLabelIcon: 'qrc:/res/newUi/approval/ic_search_nor.png'
                    placeholderText: qsTr("搜索")
                    placeholderTextItem.color: '#475883'
                    placeholderTextItem.font.family: 'PingFangSC-Regular'
                    placeholderTextItem.font.pixelSize: gUtill.dpH2(14 * approvalDocumentListPage.scale)

                    //readOnly: true

                    backgroundComponent: Rectangle {
                        width: gUtill.dpW2(350 * approvalDocumentListPage.scale)
                        height: gUtill.dpH2(34 * approvalDocumentListPage.scale)
                        radius: gUtill.dpH2(5 * approvalDocumentListPage.scale)
                        color: '#2B385C'
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                        }
                    }
                }
            }

            ListView {
                id: approvalDocumentList

                width: parent.width
                anchors.top: titleArea.bottom
                anchors.bottom: parent.bottom
                model: approvalManager.approvalDocumentsModel
                delegate: fillItemDelegate
                clip: true
            }
        }
    }

    Component {
        id: fillItemDelegate

        Rectangle {
            id: fillItemBackground
            width: parent.width
            height: gUtill.dpH2(49 * approvalDocumentListPage.scale)
            color: 'white'

            Image {
                id: fillFormatIcon

                width: gUtill.dpW2(20 * approvalDocumentListPage.scale)
                height: gUtill.dpH2(20 * approvalDocumentListPage.scale)
                anchors.left: parent.left
                anchors.leftMargin: gUtill.dpW2(16 * approvalDocumentListPage.scale)
                anchors.verticalCenter: parent.verticalCenter
                sourceSize.width: gUtill.dpW2(20 * approvalDocumentListPage.scale)
                sourceSize.height: gUtill.dpH2(20 * approvalDocumentListPage.scale)

                source: getFillFormatIcon(model.modelData.fileType)
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: fillnameText

                height: gUtill.dpH2(25 * approvalDocumentListPage.scale)
                anchors {
                    left: fillFormatIcon.right
                    leftMargin: gUtill.dpW2(8 * approvalDocumentListPage.scale)
                    right: parent.right
                    rightMargin: gUtill.dpW2(18 * approvalDocumentListPage.scale)
                    verticalCenter: parent.verticalCenter
                }

                text: model.modelData.fileName
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(18 * approvalDocumentListPage.scale)
                color: '#545454'
                verticalAlignment: Qt.AlignVCenter
            }

            Image {
                id: fillSelectedIcon

                width: gUtill.dpW2(21 * approvalDocumentListPage.scale)
                height: gUtill.dpH2(21 * approvalDocumentListPage.scale)
                anchors.right: parent.right
                anchors.rightMargin: gUtill.dpW2(16 * approvalDocumentListPage.scale)
                anchors.verticalCenter: parent.verticalCenter
                sourceSize.width: gUtill.dpW2(21 * approvalDocumentListPage.scale)
                sourceSize.height: gUtill.dpH2(21 * approvalDocumentListPage.scale)

                source: model.modelData.isSelected
                        ? 'qrc:/res/newUi/approval/ic_list_sele.png'
                        : 'qrc:/res/newUi/approval/ic_list_nor.png'
                fillMode: Image.PreserveAspectFit
            }

            CLine {
                width: parent.width
                height: gUtill.dpH2(1 * approvalDocumentListPage.scale)
                anchors.bottom: parent.bottom
                color: '#DDDFEB'
            }

            MouseArea {
                id: fillItemArea
                anchors.fill: parent
                onClicked: model.modelData.isSelected = !model.modelData.isSelected
            }
        }
    }

    CAlertDialog {
        id: alertDlg
        property string filename: ""
        titleText: "提醒"
        messageText: "文件<font color=\"#0076FF\">“" + filename+ "”</font>与您的身份不匹配，不能发送！"
        alertButtonText: "<font color=\"#0076FF\">确定</font>"
    }

    function getFillFormatIcon(type) {
        if(type === '.doc'){
            return "qrc:/res/newUi/approval/ic_cloud_doc.png";
        }
        else if(type === '.exe') {
            return "qrc:/res/newUi/approval/ic_cloud_exe.png";
        }
        else if(type === '.pdf') {
            return "qrc:/res/newUi/approval/ic_cloud_pdf.png";
        }
        else {
            return "qrc:/res/newUi/approval/ic_cloud_exe.png"
        }
    }

    ListModel {
        id: listmodel
        ListElement {
            type: 'doc'
            fillname: 'LD会议纪要－0930.doc'
        }
        ListElement {
            type: 'pdf'
            fillname: 'LD会议纪要－0930.pdf'
        }
        ListElement {
            type: 'exe'
            fillname: 'LD会议纪要－0930.exe'
        }
    }
}
