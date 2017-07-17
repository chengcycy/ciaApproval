import QtQuick 2.0
import com.syberos.basewidgets 2.0

CPage {
    id: authPage

    property string  server
    property string  name
    property string  password
    property int pixelSize: gUtill.dpH(17*fp)
    property int textSize: gUtill.dpH(14*fp)
    property color statusBarClr: "#f7f7f7"
    color:"#f7f7f7"
    onStatusChanged: {
        if (status === CPageStatus.WillShow) {
            authPage.statusBarHoldEnabled = true
            authPage.statusBarHoldItemColor = statusBarClr
        }
    }
    contentAreaItem: Item {
        anchors.fill :parent

        Flickable{
            id: filckableInput
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            contentHeight: parent.height

            Connections {
                target: gInputContext
                onSoftwareInputPanelVisibleChanged: {
                    if(gInputContext.softwareInputPanelVisible) {
                        filckableInput.contentHeight = filckableInput.parent.height + 200
                    } else {
                        filckableInput.contentHeight = filckableInput.parent.height
                    }
                }
            }
            Image {
                id: logoImage
                source:"qrc:/res/ciaapprovalui.png"
                height:gUtill.dpH(76*fp)
                width: gUtill.dpW(106*fp)
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: gUtill.dpH(78*fp)
                antialiasing: true
            }

//            Image {
//                id:srvTip

//                anchors{
//                    left: parent.left
//                    leftMargin:gUtill.dpW(28*fp)
//                    verticalCenter: srvLineEdit.verticalCenter
//                }
//                width: gUtill.dpW(21*fp)
//                height:gUtill.dpH(21*fp)
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/res/newUi/server@2x.png"
//            }

//            CLineEdit {
//                id: srvLineEdit
//                anchors.top: logoImage.bottom
//                anchors.left: srvTip.right
//                anchors.right:parent.right
//                anchors.topMargin: gUtill.dpH(54*fp)
//                anchors.leftMargin: gUtill.dpW(17*fp)
//                anchors.rightMargin: gUtill.dpW(35*fp)

//                height: gUtill.dpH(58*fp)
//                passwordLabelEnabled: false
//                clip: true
//                textColor:"#435377"
//                font.pixelSize: pixelSize
//                placeholderText:os.i18n.ctr(qsTr("请输入服务器"))
//                validator:RegExpValidator{regExp:/^[a-zA-Z0-9.][a-zA-Z0-9.]*$/}
//                inputMethodHints: Qt.ImhPreferLatin/*| Qt.ImhPreferNumbers */
//                inputMethodHintExtensions: {
//                    var args = {};
//                    args["enterKeyText"] = "next";
//                    return args;
//                }
//                text: loginManager.getLoginService();

//                onTextChanged: {
//                    passWordEdit.text = ""

//                    if(authPage.state !== "hidden") {
//                        authPage.state = "hidden"
//                    }
//                }

//                onKeyPressed: {
//                    if (key === Qt.Key_Return)
//                    {
//                        userLineEdit.forceActiveFocus()
//                    }
//                }
//            }
//            CLine {
//                id: lineUser
//                anchors.top: logoImage.bottom
//                anchors.left: userLineEdit.left
//                height: gUtill.dpH(1*fp)
//                width: userLineEdit.width
//                z: parent.z+2
//                color: "#e7e9f0"
//            }
            Image{
                id:userTip

                anchors{
                    left: parent.left
                    leftMargin: gUtill.dpW(28*fp)
                    verticalCenter: userLineEdit.verticalCenter
                }
                width: gUtill.dpW(21*fp)
                height: gUtill.dpH(21*fp)
                fillMode: Image.PreserveAspectFit
                source: "qrc:/res/id.png"
            }

            CLineEdit {
                id: userLineEdit
                anchors.top: logoImage.bottom
                anchors.topMargin: gUtill.dpH2(60)
                anchors.left: userTip.right
                anchors.right:parent.right
                anchors.leftMargin: gUtill.dpW(17*fp)/*srvLineEdit.text ==="" ? 50 : 0*/
                anchors.rightMargin: gUtill.dpW(35*fp)

                height: gUtill.dpH(58*fp)
                passwordLabelEnabled: false
                clip: true
                textColor: "#425377"
                font.pixelSize: pixelSize
                placeholderText: os.i18n.ctr(qsTr("请输入手机号"))
                validator: RegExpValidator{regExp:/^[0-9]*$/}
                inputMethodHints: Qt.ImhDialableCharactersOnly /*|Qt.ImhPreferNumbers*/
                inputMethodHintExtensions: {
                    var args = {};
                    args["enterKeyText"] = "next";
                    return args;
                }
                text: ""

                onTextChanged: {
                    passWordEdit.text = "";

                    if(authPage.state !== "hidden") {
                        authPage.state = "hidden"
                    }
                }

                onKeyPressed: {
                    if (key === Qt.Key_Return)
                    {
                        passWordEdit.forceActiveFocus()
                    }
                }
            }
            CLine {
                id: linePassword
                anchors.top: userLineEdit.bottom
                anchors.left: userLineEdit.left
                anchors.right: userLineEdit.right
                z: parent.z+2
                height: gUtill.dpH(1*fp)
                color: "#e7e9f0"
            }

            Image {
                id: srvPwd
                anchors{
                    left: parent.left
                    leftMargin: gUtill.dpW(28*fp)
                    verticalCenter: passWordEdit.verticalCenter
                }
                width: gUtill.dpW(21*fp)
                height:gUtill.dpH(21*fp)
                fillMode: Image.PreserveAspectFit
                source: "qrc:/res/password.png"
            }
            CLineEdit {
                id: passWordEdit
                anchors.top: linePassword.bottom
                anchors.left: srvPwd.right
                anchors.right: parent.right
                anchors.leftMargin: gUtill.dpW(17*fp)
                anchors.rightMargin: gUtill.dpW(35*fp)

                clearLabelRightMargin:40
                height: gUtill.dpH(58*fp)
                passwordLabelEnabled: false
                echoMode: TextInput.Password
                clip: true
                textColor:"#435377"
                font.pixelSize: pixelSize
                placeholderText:os.i18n.ctr(qsTr("请输入密码"))

                inputMethodHints: Qt.ImhPreferLatin//Qt.ImhHiddenText
                inputMethodHintExtensions: {
                    var args = {};
                    args["enterKeyText"] = "complete";
                    return args;
                }

                onKeyPressed: {
                    if (key === Qt.Key_Return)
                    {
                        filckableInput.login()
                    }
                }


                CButton{
                    id: seePassword;
                    anchors.right: parent.right
//                    anchors.rightMargin: gUtill.dpW2(20)
                    iconSource: passWordEdit.echoMode === TextInput.Normal ? "qrc:/res/echo_normal.png" : "qrc:/res/echo_pwd.png"
                    backgroundEnabled: false
                    width: gUtill.dpW(22*fp)
                    height: parent.height
                    onReleased: {
                        if(containsMouse){
                            passWordEdit.echoMode = passWordEdit.echoMode === TextInput.Normal ? TextInput.Password : TextInput.Normal;
                        }
                    }
                }

            }
            CLine {
                id: lineEnterword
                anchors.top: passWordEdit.bottom
                anchors.left: passWordEdit.left
                anchors.right: passWordEdit.right
                z: parent.z+2
                height: gUtill.dpH(1*fp)
                color: "#e7e9f0"

            }

            CButton {
                id: loginButton

                anchors.top: lineEnterword.bottom
                anchors.topMargin: gUtill.dpW(35*fp)
                anchors.horizontalCenter: parent.horizontalCenter
                height:gUtill.dpW(53*fp)
                width:gUtill.dpW(221*fp)

                opacity:  pressed ?0.7:1
                text:os.i18n.ctr(qsTr("登 录"))
                textColor:  "#ffffff"
                pixelSize: gUtill.dpH(22*fp)

                backgroundComponent: Rectangle {
                    anchors.fill: parent
                    color:"#6021dc"
                    radius: gUtill.dpW(28*fp)

                }

                onClicked: filckableInput.login()

                Behavior on opacity {
                    PropertyAnimation { duration: 200 }
                }
            }

            //            CButton{
            //                id:maillogin
            //                anchors.top: loginButton.bottom
            //                anchors.topMargin: gUtill.dpH(28*fp)
            //                anchors.leftMargin: gUtill.dpW(11*fp)
            //                anchors.left: parent.left
            //                height:gUtill.dpH(28*fp)
            //                width:gUtill.dpW(110*fp)
            //                text:os.i18n.ctr(qsTr("身份证登录"))
            //                pixelSize: textSize
            //                textColor:  "#0c2559"
            //                backgroundComponent: Rectangle {
            //                    anchors.fill: parent
            //                    color:"transparent"
            //                }
            //                onClicked: {
            //                    pageStack.replace(Qt.resolvedUrl("AuthMainPage.qml"), "", true);
            //                }
            //            }

            CIndicatorDialog {
                id:loadingDialog
                messageText: os.i18n.ctr(qsTr("正在登录中..."))
                messageTextPixelSize:textSize
            }

            function login() {
                //                if(srvLineEdit.text ===""){
                //                    gToast.requestToast("服务器不能为空","","");
                //                    return;
                //                }
                if(userLineEdit.text ===""){
                    gToast.requestToast("手机号不能为空","","");
                    return;
                }
                if(passWordEdit.text ===""){
                    gToast.requestToast("密码不能为空","","");
                    return;
                }
                if(userLineEdit.text === "") {
                    userLineEdit.focus = true
                    gToast.requestToast("帐号不能为空","","");
                } else if(passWordEdit.text === "") {
                    passWordEdit.focus = true
                    gToast.requestToast("密码不能为空","","");
                } else {
                    //                    loadingDialog.show();
                }
            }
        }
    }
}
