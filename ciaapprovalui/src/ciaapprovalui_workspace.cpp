#include "ciaapprovalui_workspace.h"
#include <QDebug>
#include <QQmlContext>
#include <QFile>
#include <csystempackagemanager.h>


QString ciaapprovalui_Workspace::myUserId()
{
    QSettings settings(CONFIG_FILE, QSettings::IniFormat);
    QString myUserId = settings.value("myId","").toString();
    qDebug()<<Q_FUNC_INFO<<"myUserId:"<<myUserId;
    return myUserId;
}

ciaapprovalui_Workspace::ciaapprovalui_Workspace()
    : CWorkspace()
{

    bool insatllLinkDood = false;
    CSystemPackageManager pkg;
    QList<QSharedPointer<CPackageInfo> > list = pkg.packageInfoList();
    for(auto i :list){
       if(i->sopid() == "com.vrv.linkDood"){
           insatllLinkDood = true;
           break;
       }
    }
    if(!insatllLinkDood){
        QFile file(CONFIG_FILE);
        file.remove();
    }

    m_view = SYBEROS::SyberosGuiCache::qQuickView();
    QObject::connect(m_view->engine(), SIGNAL(quit()), qApp, SLOT(quit()));

    m_pOrgManager = QSharedPointer<OrgManager>(new OrgManager(this));
    if(!m_pOrgManager.data()){
        qDebug() << Q_FUNC_INFO << "m_pOrgManager init error !!!";
    }
    m_view->engine()->rootContext()->setContextProperty("orgManager", m_pOrgManager.data());

    m_pOrgNavBarManager = QSharedPointer<OrgManagerNavBar>(new OrgManagerNavBar(this));
    if(!m_pOrgNavBarManager.data()){
        qDebug() << Q_FUNC_INFO << "m_pOrgNavBarManager init error !!!";
    }
    m_view->engine()->rootContext()->setContextProperty("orgNavBarManager", m_pOrgNavBarManager.data());

    int mfp = 1;
    QVariant fp;
    fp.setValue(mfp);
    m_view->engine()->rootContext()->setContextProperty("fp",fp);
    m_view->engine()->rootContext()->setContextProperty("gUtill",&mUtills);
    m_view->engine()->rootContext()->setContextProperty("mainApp",this);

    m_view->setSource(QUrl("qrc:/qml/main.qml"));
    m_view->showFullScreen();

    myUserId();
}

void ciaapprovalui_Workspace::onLaunchComplete(Option option, const QStringList& params)
{
    Q_UNUSED(params)

    switch (option) {
    case CWorkspace::HOME:
        qDebug()<< "Start by Home";
        break;
    case CWorkspace::URL:
        break;
    case CWorkspace::EVENT:
        break;
    case CWorkspace::DOCUMENT:
        break;
    default:
        break;
    }
}

QString ciaapprovalui_Workspace::currentID() const
{
    return m_currentID;
}

void ciaapprovalui_Workspace::setCurrentID(const QString currentID)
{
    qDebug() << "ciaapprovalui_Workspace::setCurrentID" << currentID;
    if (m_currentID != currentID) {
        m_currentID = currentID;
        emit currentIDChanged();
    }
}

QString ciaapprovalui_Workspace::currentName() const
{
    return m_currentName;
}

void ciaapprovalui_Workspace::setCurrentName(const QString currentName)
{
    if (m_currentName != currentName) {
        m_currentName = currentName;
        emit currentNameChanged();
    }
}

