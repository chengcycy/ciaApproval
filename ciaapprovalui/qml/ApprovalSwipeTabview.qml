import QtQuick 2.0
import com.syberos.basewidgets 2.0
CSwipeTabView{
    id:swipeTabview

    tabVisible: false
    tabPosition:Qt.BottomEdge
    
    function addPage(url){
        var component = Qt.createComponent(Qt.resolvedUrl("./SwipeTab.qml"));
        if (component.status === Component.Ready) {
            var obj  = component.createObject(swipeTabview);
            obj.imageSource = url;
        }
    }
}
