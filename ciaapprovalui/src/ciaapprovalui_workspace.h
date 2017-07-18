#ifndef __CIAAPPROVALUI_WORKSPACE__
#define __CIAAPPROVALUI_WORKSPACE__

#include <QQuickView>
#include <QQuickWindow>
#include <QQmlEngine>
#include <QQmlComponent>
#include <SyberosGuiCache>
#include <cgui_application.h>
#include <cworkspace.h>
#include <QSettings>

#include "cutills.h"
#include "consttype.h"
#include "orgmanager.h"

using namespace SYBEROS;

class ciaapprovalui_Workspace : public CWorkspace
{
    Q_OBJECT
    Q_PROPERTY(QString currentID READ currentID WRITE setCurrentID NOTIFY currentIDChanged)
private:
    QQuickView *m_view;
    CUtills    mUtills;
    QSharedPointer<OrgManagerNavBar> m_pOrgNavBarManager;
    QSharedPointer<OrgManager> m_pOrgManager;
    QString    m_currentID;
public:
    Q_INVOKABLE QString myUserId();

    ciaapprovalui_Workspace();

    // 应用启动结束时，回调此函数。根据传入的option，应用可以区分启动的方式。
    void onLaunchComplete(Option option, const QStringList& params);

    QString currentID() const;
    void setCurrentID(const QString currentID);
signals:
    void currentIDChanged();
};


#endif //__CIAAPPROVALUI_WORKSPACE__
