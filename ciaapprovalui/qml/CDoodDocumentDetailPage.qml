import QtQuick 2.0
import com.syberos.basewidgets 2.0
import QtWebKit 3.0

CPage{
    id: documentDetailPage

    property real scale: 1.92
    property int page: 1
    property var currentDoc: ({})

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
                height: gUtill.dpH2(64 * documentDetailPage.scale)
                anchors.top: parent.top

                color: '#394871'

                Text {
                    id: textTitle

                    height: gUtill.dpH2(24 * documentDetailPage.scale)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: gUtill.dpH2(30 * documentDetailPage.scale)

                    text: currentDoc.fileName
                    font.family: 'PingFangSC-Regular'
                    font.pixelSize: gUtill.dpH2(17 * documentDetailPage.scale)
                    color: 'white'
                    verticalAlignment: Qt.AlignBottom
                }

                Rectangle {
                    id: buttonBack

                    width: gUtill.dpW2(53 * documentDetailPage.scale)
                    height: gUtill.dpH2(22 * documentDetailPage.scale)
                    anchors {
                        left: parent.left
                        leftMargin: gUtill.dpW2(13 * documentDetailPage.scale)
                        top: parent.top
                        topMargin: gUtill.dpH2(32 * documentDetailPage.scale)
                    }

                    color: 'transparent'

                    Image {
                        id: backButtonIcon

                        width: gUtill.dpW2(12 * documentDetailPage.scale)
                        height: gUtill.dpH2(20 * documentDetailPage.scale)
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: gUtill.dpW2(12 * documentDetailPage.scale)
                        sourceSize.height: gUtill.dpH2(20 * documentDetailPage.scale)
                        source: 'qrc:/res/approval/ic_back.png'
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: backButtonText

                        height: parent.height
                        anchors.left: backButtonIcon.right
                        anchors.leftMargin: gUtill.dpW2(7 * documentDetailPage.scale)
                        anchors.verticalCenter: backButtonIcon.verticalCenter

                        text: qsTr('返回')
                        font.family: 'PingFangSC-Regular'
                        font.pixelSize: gUtill.dpH2(17 * documentDetailPage.scale)
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

            ApprovalSwipeTabview {
                id: documentContent

                anchors{
                    top: titleArea.bottom
                    left: parent.left
                    right: parent.right
                    bottom: pageInfo.top
                    margins: gUtill.dpH2(10 * documentDetailPage.scale)
                }

                onCurrentIndexChanged: {
                    documentDetailPage.page = currentIndex + 1
                }

                Component.onCompleted: {
                    for (var i = 1; i <= currentDoc.pageSize;
                         i++)
                    {
                        documentContent.addPage(currentDoc.filePath + '&pageNum=' + i)
                    }
                }
            }

            Text {
                id: pageInfo

                width: gUtill.dpW2(51 * documentDetailPage.scale)
                height: gUtill.dpH2(18 * documentDetailPage.scale)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: gUtill.dpH2(10 * documentDetailPage.scale)
                anchors.horizontalCenter: parent.horizontalCenter

                text: '< ' + documentDetailPage.page + '/' + currentDoc.pageSize + ' >'
                font.family: 'PingFangSC-Regular'
                font.pixelSize: gUtill.dpH2(15 * documentDetailPage.scale)
                color: '#030303'
                verticalAlignment: Text.AlignBottom
            }
        }
    }
}
