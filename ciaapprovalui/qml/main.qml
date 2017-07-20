import QtQuick 2.0
import com.syberos.basewidgets 2.0

import "./CDoodApprovalRequest.js" as Helper

CPageStackWindow {
    id: mainPageView
    inputFactor: 0
    keyHandle:false
    onBackKey:{
        if(clearFocus()){
            event.accepted =true
            return
        }
        console.log('==================================depth:'+mainPageView.pageStack.depth)
        if(mainPageView.pageStack.depth > 1) {
            mainPageView.pageStack.pop();
        } else {
            winHide()
        }
    }
    Keys.onReleased:{
        if (event.key === Qt.Key_Home) {
            winHide();
        }
    }
    initialPage:CPage{
        id: startPage
        anchors.fill: parent
        orientationLock: CPageOrientation.LockPortrait

        onStateChanged: {
            if (status == CPageStatus.WillShow) {
                gScreenInfo.setWindowProperty("STATUSBAR_VISIBLE",true)
                gScreenInfo.setWindowProperty("STATUSBAR_STYLE","transBlack")
            }
        }
    }
    Component.onCompleted: {
        console.log('userId:'+mainApp.myUserId()+',Name:'+mainApp.myName());
        pageStack.clear();
        var userId = mainApp.myUserId();
        /*        if(userId !== ""){
            mainApp.currentID = mainApp.myUserId();
            mainApp.currentName = mainApp.myName();
            pageStack.push(Qt.resolvedUrl("./CDoodApprovalPage.qml"), "", true);
        }else*/{
            var page = pageStack.push(Qt.resolvedUrl("./AuthPage.qml"), "", true);
            page.btnLogin.connect(function(phone,passwd){
                loadingDialog.show();
                Helper.getJSONFile(function(resp){
                    console.log("resp:"+resp);
                    var data = JSON.parse(resp);
                    loadingDialog.hide();
                    var loginOk = false;
                    if(data.hasOwnProperty('staffList')){
                        var staffList = data.staffList;
                        for(var i =0;i<staffList.length;++i){
                            var item = staffList[i];
                            if((item.phone+'') === phone&& (item.password+'') === passwd){
                                mainApp.currentID = item.userID;
                                mainApp.currentName = item.userName;
                                pageStack.clear();
                                pageStack.push(Qt.resolvedUrl("./CDoodApprovalPage.qml"), "", true);
                                loginOk = true;
                                break;
                            }
                        }
                    }
                    if(!loginOk){
                       gToast.requestToast("账户不存在或密码错误！","","");
                    }
                });
            });
        }
    }

    CIndicatorDialog {
        id:loadingDialog
        canceledOnBackKeyReleased: true
        messageText: os.i18n.ctr(qsTr("正在登录中..."))
        messageTextPixelSize:gUtill.dpH2(32);
    }

}
