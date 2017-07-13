#include "ciaapprovalui_workspace.h"
#include <QDebug>
#include <QQmlContext>

ciaapprovalui_Workspace::ciaapprovalui_Workspace()
    : CWorkspace()
{
    m_view = SYBEROS::SyberosGuiCache::qQuickView();
    QObject::connect(m_view->engine(), SIGNAL(quit()), qApp, SLOT(quit()));
    m_view->setSource(QUrl("qrc:/qml/main.qml"));

    int mfp = 1;
    QVariant fp;
    fp.setValue(mfp);
    m_view->engine()->rootContext()->setContextProperty("fp",fp);
    m_view->engine()->rootContext()->setContextProperty("gUtill",&mUtills);

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

