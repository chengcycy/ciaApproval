import QtQuick 2.0
import com.syberos.basewidgets 2.0
import "../"
import "../chat"

CPage {
    id: appStorePage

    statusBarHoldEnabled: false
    Component.onCompleted: {
        //设置是否显示状态栏，应与statusBarHoldItemEnabled属性一致
        gScreenInfo.setStatusBar(true);

        //设置状态栏样式，取值为"black"，"white"，"transwhite"和"transblack"
        gScreenInfo.setStatusBarStyle("transwhite");
    }

    Connections {
        target: storeAppManager
        onAddOrDeleteStoreAppResult:{
            loadingDialog.hide();
        }
    }

    contentAreaItem: Rectangle {

        anchors.fill: parent
        color:"#F2F2F2"

        Rectangle {
            id: titleArea

            width: parent.width
            height: gUtill.dpH2(211.2*fp)
            color: "#394871"

            Text {
                id: textTitle

                height: gUtill.dpH2(46.08*fp)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: gUtill.dpH2(57.6*fp)

                text: '应用商店'
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(32.64*fp)
                color: 'white'
                verticalAlignment: Qt.AlignBottom
            }

            Rectangle {
                id: buttonBack

                width: gUtill.dpW2(101.76*fp)
                height: gUtill.dpH2(42.24*fp)
                anchors {
                    left: parent.left
                    leftMargin: gUtill.dpW2(24.96*fp)
                    top: parent.top
                    topMargin: gUtill.dpH2(61.44*fp)
                }

                color: 'transparent'

                Image {
                    id: backButtonIcon

                    width: gUtill.dpW2(23.04*fp)
                    height: gUtill.dpH2(38.4*fp)
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    sourceSize.width: gUtill.dpW2(23.04*fp)
                    sourceSize.height: gUtill.dpH2(38.4*fp)
                    source: 'qrc:/res/newUi/approval/ic_back.png'
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: backButtonText

                    height: parent.height
                    anchors.left: backButtonIcon.right
                    anchors.leftMargin: gUtill.dpW2(13.44*fp)
                    anchors.verticalCenter: backButtonIcon.verticalCenter

                    text: qsTr('返回')
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(32.64*fp)
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
                id: searchInput

                width: parent.width-gUtill.dpW2(40*fp)
                height: gUtill.dpH2(70*fp)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: gUtill.dpH2(15*fp)
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#2B385C"
                radius: gUtill.dpH2(10*fp)
                //anchors.fill: parent

                Image {
                    id: img_sch
                    source: "qrc:/res/newUi/ic_search_focus@1.5x.png"
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width / 2 - gUtill.dpW2(60*fp)
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: qsTr("搜索")
                    anchors.left: img_sch.right
                    anchors.leftMargin: gUtill.dpW2(10*fp)
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: gUtill.dpH2(30*fp)
                    color: "#394871"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        sch_page.show();
                        sch_page.inputEdit.forceActiveFocus();
                    }
                }
            }

            ChatSearchListPage {
                id: sch_page
                visible: false
            }
        }

        ListView {
            id: addedAppList
            width: parent.width
            height: gUtill.dpH2((27 * 1.92 + 120 * count)*fp)
            anchors.top: titleArea.bottom
            anchors.bottom: parent.bottom

            model: storeAppManager
            delegate: appListDelegate
            clip: true

            section.property: model.modelData.name
            section.criteria: ViewSection.FullString
            section.delegate: appListHeader
        }
    }

    Component {
        id: appListHeader

        Rectangle {
            id: appListHeaderArea

            width: parent.width
            height: gUtill.dpH2(27 * 1.92*fp)

            color: '#F2F2F5'

            Text {
                id: appListHeaderText

                height: gUtill.dpH2(18 * 1.92*fp)
                anchors {
                    left: parent.left
                    leftMargin: gUtill.dpW2(15 * 1.92*fp)
                    top: parent.top
                    topMargin: gUtill.dpH2(3 * 1.92*fp)
                }

                text: section
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(13 * 1.92*fp)
                color: '#394871'
                verticalAlignment: Qt.AlignVCenter
            }
        }
    }

    Component {
        id: appListDelegate

        Rectangle {
            id : background
            width: parent.width
            height: gUtill.dpH2(120*fp)
            color: "white"

            CDoodRecHeaderImage {
                id: headPortraitImage
                width: gUtill.dpW2(90*fp)
                height: gUtill.dpH2(90*fp)
                anchors.left: parent.left
                anchors.leftMargin: gUtill.dpW2(25*fp)
                anchors.verticalCenter: parent.verticalCenter
                name: model.modelData.name
                iconSource:setIcon("3", model.modelData.avatar)
            }

            Text {
                id: nameText
                height: gUtill.dpH2(33*fp)
                anchors.left: headPortraitImage.right
                anchors.leftMargin: gUtill.dpW2(20*fp)
                anchors.rightMargin: gUtill.dpW2(20*fp)
                anchors.top: parent.top
                anchors.topMargin: gUtill.dpH2(25*fp)
                font.pixelSize: gUtill.dpH2(30*fp)
                clip: true
                color: "#000000"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                text: model.modelData.name
            }

            Text {
                id: signText
                height: gUtill.dpH2(33*fp)
                anchors.left: nameText.left
                anchors.rightMargin: gUtill.dpW2(20*fp)
                anchors.top: nameText.bottom
                anchors.topMargin: gUtill.dpH2(15*fp)
                font.pixelSize: gUtill.dpH2(22*fp)
                clip: true
                color: "#a8a8a8"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                text: model.modelData.appSign
            }

            Rectangle {
                id: addButton
                width: gUtill.dpW2(92*fp)
                height: gUtill.dpH2(52*fp)
                anchors.right: parent.right
                anchors.rightMargin: gUtill.dpW2(20*fp)
                anchors.verticalCenter: parent.verticalCenter
                radius: height / 2
                border.color: model.modelData.status === "" ? "#003658" : "red"
                border.width: gUtill.dpH2(2*fp)
                color: model.modelData.status === "" ? "#003658" : "white"

                Text {
                    id: buttonText
                    anchors.centerIn: parent
                    font.pixelSize: gUtill.dpH2(28*fp)
                    text: model.modelData.status === "" ? "添加" : "停用"
                    color: model.modelData.status === "" ? "white" : "red"
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(model.modelData.status===""){
                            loadingDialog.show();
                            storeAppManager.addApp(model.modelData.id);
                            storePartAppManager.addApp(model.modelData.id);
                        }
                        else{
                            loadingDialog.show();
                            storeAppManager.deleteApp(model.modelData.id);
                            storePartAppManager.deleteApp(model.modelData.id);
                        }
                    }
                }
            }

            CLine {
                width: gUtill.dpW2(3*fp)
                anchors.left: parent.left
                color:"#dedfdc"
                anchors.leftMargin: gUtill.dpW2(25*fp)
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                z: parent.z+2
            }
        }
    }

    CIndicatorDialog {
        id:loadingDialog
        messageText: os.i18n.ctr(qsTr("正在操作中..."))
        onBackKeyReleased: {
            loadingDialog.hide();
        }
    }
}
