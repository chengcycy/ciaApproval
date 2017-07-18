
import QtQuick 2.3
import com.syberos.basewidgets 2.0
Rectangle{
    id:root
    implicitHeight: gUtill.dpH2(90)
    width:parent.width
    color: borderColor
    property color borderColor: "white"
    property var tabView: null
    /*! 标签高度 */
    property real tabHeight: gUtill.dpH2(90)

    /*! 标签宽度 */
    property real tabWidth: gUtill.dpW2(240)
    property string highlightColor: '#023958'
    property string commonColor: '#A5A5A5'

    signal tabClick()
    Rectangle {
        id: bar
        anchors.centerIn: root
        color: borderColor
        height: row.height
        width: row.width
        Row {
            id: row
            height: tabHeight
            anchors.centerIn: parent
            spacing: gUtill.dpH2(1)

            Repeater {
                id: repeater
                model: tabView.tabModel
                delegate: MouseArea {
                    width: tabWidth
                    height: tabHeight
                    onClicked: {
                        tabView.currentIndex = index;
                        emit: tabClick();
                    }
                    Text{
                        id:title
                        text:tab.title
                        color:index === tabView.currentIndex?highlightColor:commonColor
                        font.pixelSize: gUtill.dpH2(30)
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: gUtill.dpH2(23)
                    }

                    Rectangle{
                        id:line
                        height: gUtill.dpH2(5)
                        width: gUtill.dpW2(140)
                        color: highlightColor
                        visible: index === tabView.currentIndex
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: title.bottom
                        anchors.topMargin: gUtill.dpH2(20)
                    }
                }
            }
        }
    }
    CLine{
        height: gUtill.dpH2(2)
        anchors.bottom: parent.bottom
    }
}

//Rectangle {
//    id: tabBar
//    implicitHeight: 120
//    anchors.left: parent.left
//    anchors.right: parent.right
//    color: "white"

//    signal tabClick()
//    /*! TabBar所在的TabView，必须赋值 */
//    property var tabView: null

//    /*! 标签高度 */
//    property real tabHeight: 60

//    /*! 标签宽度 */
//    property real tabWidth: 240

//    /*! 字体大小 */
//    property int titlePixelSize: gUiConst.getValue("S3")

//    /*! 文字颜色 */
//    property color titleColor: "#1B305E"

//    /*! 高亮文字颜色 */
//    property color titleHighlightColor: "white"

//    /*! 标签颜色 */
//    property color tabColor: "white"

//    /*! 高亮标签颜色 */
//    property color tabHighlightColor: "#1B305E"

//    /*! 框线颜色 */
//    property color borderColor: "#1B305E"

//    /*!
//        \qmlproperty color CTabView::backgroundColor
//        标签栏背景颜色
//    */
//    property alias backgroundColor: tabBar.color

//    objectName: "CTabBar"

//    /*!
//        \qmlproperty string CTabView::theme
//        外观风格样式

//        \list
//        \li "light" (default) - 白色风格
//        \li "dark" - 黑色风格
//        \endlist
//    */
//    property string theme: tabView.hasOwnProperty("theme") ? tabView.theme : "light"

//    /*! 标识动画是否正在进行，只读属性。*/
//    readonly property bool animating: anchorAnimation.running

//    Rectangle {
//        id: bar
//        anchors.centerIn: tabBar
//        color: borderColor
//        height: row.height+4
//        width: row.width+4
//        radius: height/2

//        Row {
//            id: row
//            height: tabHeight
//            anchors.centerIn: parent
//            spacing: 1

//            Repeater {
//                id: repeater
//                model: tabView.tabModel

//                delegate: MouseArea {
//                    width: tabWidth
//                    height: tabHeight

//                    Rectangle {
//                        id: leftRec
//                        anchors.left: parent.left
//                        height: parent.height
//                        width: index === 0 ? height : (index === repeater.count - 1 ? tabWidth - 0.5*height : tabWidth)
//                        radius: index === 0 ? height/2 : 0
//                        color: index === tabView.currentIndex ? tabHighlightColor : tabColor

//                        Behavior on color {
//                            ColorAnimation { duration: gSystemUtils.durationRatio*100 }
//                        }
//                    }
//                    Rectangle {
//                        id: rightRec
//                        anchors.right: parent.right
//                        height: parent.height
//                        width: index === 0 ? tabWidth - 0.5*height : (index === repeater.count - 1 ? height : 0)
//                        radius: index === repeater.count - 1 ? height/2 : 0
//                        color: index === tabView.currentIndex ? tabHighlightColor : tabColor

//                        Behavior on color {
//                            ColorAnimation { duration: gSystemUtils.durationRatio*100 }
//                        }
//                    }

//                    Text {
//                        text: tab.title
//                        anchors.centerIn: parent
//                        color: index === tabView.currentIndex ? titleHighlightColor : titleColor //tabView.titleHighlightColor : tabView.titleColor
//                        font.pixelSize: titlePixelSize //tabView.titlePixelSize

//                        Behavior on color {
//                            ColorAnimation { duration: gSystemUtils.durationRatio*100 }
//                        }
//                    }

//                    onClicked: {
//                        tabView.currentIndex = index;
//                        emit: tabClick();
//                    }
//                }
//            }
//        }
//    }
//    CLine{
//        height: 2
//        anchors.bottom: parent.bottom
//    }
//    state: tabView.tabPosition === Qt.TopEdge ?
//               (tabView.tabVisible ? "top" : "top-hide") : (tabView.tabVisible ? "bottom" : "bottom-hide")
//    states: [
//        State {
//            name: "top"
//            AnchorChanges {
//                target: tabBar
//                anchors.top: parent.top
//                anchors.bottom: undefined
//            }
//        },
//        State {
//            name: "bottom"
//            AnchorChanges {
//                target: tabBar
//                anchors.top: undefined
//                anchors.bottom: parent.bottom
//            }
//        },
//        State {
//            name: "top-hide"
//            AnchorChanges {
//                target: tabBar
//                anchors.bottom: parent.top
//                anchors.top: undefined
//            }
//        },
//        State {
//            name: "bottom-hide"
//            AnchorChanges {
//                target: tabBar
//                anchors.bottom: undefined
//                anchors.top: parent.bottom
//            }
//        }
//    ]
//    transitions: Transition {
//        AnchorAnimation {
//            id: anchorAnimation
//            duration: gSystemUtils.durationRatio*100; easing.type: Easing.OutExpo
//            onStarted: if(tabView.tabVisible) tabBar.visible = true;
//            onStopped: if(!tabView.tabVisible) tabBar.visible = false;
//        }
//    }
//}
