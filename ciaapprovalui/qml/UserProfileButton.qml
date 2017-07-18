import QtQuick 2.0
import com.syberos.basewidgets 2.0

Rectangle{
    id:comp
    
    property string leftText: ""
    property url rightImg:""
    property string rigthText: ""
    property bool showLine:true
    property bool editable:false
    property int  rightTextMaxLen: 460

    property bool  bShowRigthImg:false
    property alias leftTextFont: leftTip.font
    property alias leftTextColor: leftTip.color
    property alias rightTextFont: rigthText.font
    property alias rightTextColor: rigthText.color
    signal clicked()
    height: gUtill.dpH(38*fp)
    color: "white"

    anchors.left: parent.left
    anchors.right: parent.right

    Text{
        id:leftTip
        
        text:leftText
        font.pixelSize: gUtill.dpH(16*fp)
        color: "#545454"

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: gUtill.dpW(16*fp)
    }
    CDoodHeaderImage {
        id: rightIcon
        visible: bShowRigthImg

        iconSource: setIcon("1",comp.rightImg)
        anchors{
            right: arrowTip.left
            rightMargin: gUtill.dpW(11*fp)
            verticalCenter: parent.verticalCenter
        }
    }
    Text {
        id:rigthText
        
        text:comp.rigthText
        font.pixelSize: gUtill.dpH(16*fp)
        width:300
        elide: Text.ElideRight
        clip:true
        color: "#c7c7cc"
        maximumLineCount: 1
        horizontalAlignment:Text.AlignRight
        onTextChanged: {
            //console.log("text changed:"+text);
            rigthText.width = setWidth();
        }

        anchors{
            right: arrowTip.left
            rightMargin: gUtill.dpW(5*fp)
            verticalCenter: parent.verticalCenter
        }
        function setWidth(){
            var tmp = rigthText.contentWidth+10;
            //console.log("len:"+tmp);
            if(tmp>rightTextMaxLen){
                return rightTextMaxLen;
            }else if(tmp <300){
                return 300;
            }else{
                return tmp;
            }
        }
    }
    Image {
        id:arrowTip
        
        visible: comp.editable
        source: "qrc:/res/ic_next_more@1.5x.png"
        anchors{
            right: parent.right
            rightMargin: gUtill.dpW(11*fp)
            verticalCenter: parent.verticalCenter
        }
    }
    CLine{
        visible: comp.showLine
        anchors.bottom: parent.bottom
        color:"#dddfeb"
        anchors.left:parent.left
        anchors.right: parent.right
        anchors.leftMargin: gUtill.dpW(16*fp)
    }
    MouseArea{
        anchors.fill: parent
        onPressed: parent.color = "#cdcdcd"
        onReleased: parent.color = "white"
        onCanceled: parent.color = "white"
        onClicked: {
            emit: comp.clicked();
        }
    }
}
