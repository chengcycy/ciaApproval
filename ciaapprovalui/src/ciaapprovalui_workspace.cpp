#include "ciaapprovalui_workspace.h"
#include <QDebug>
#include <QQmlContext>

ciaapprovalui_Workspace::ciaapprovalui_Workspace()
    : CWorkspace()
{
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

    m_view->setSource(QUrl("qrc:/qml/main.qml"));
    m_view->showFullScreen();
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

