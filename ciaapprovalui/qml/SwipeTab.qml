import QtQuick 2.0
import com.syberos.basewidgets 2.0
CSwipeTab {
    title: "tab"
    property alias  imageSource: page.source
    Image {
        id:page
        anchors.fill: parent
    }
}
