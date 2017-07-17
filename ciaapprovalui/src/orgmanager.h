#ifndef ORGMANAGER_H
#define ORGMANAGER_H

#include <QObject>
#include "cdoodlistmodel.h"
#include "contactdef.h"
#include "consttype.h"

class OrgItem:public QObject{
    Q_OBJECT
    Q_PROPERTY(qint64 id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool isDepart READ isDepart WRITE setIsDepart NOTIFY isDepartChanged)
    Q_PROPERTY(QString head READ head WRITE setHead NOTIFY headChanged)
    Q_PROPERTY(bool isSel READ isSel WRITE setIsSel NOTIFY isSelChanged)
public:
    OrgItem(QObject*parent = 0);
    virtual ~OrgItem();

    qint64 id() const;
    QString name() const;
    bool isDepart() const;
    QString head() const;
    bool isSel();

    void setId(qint64 id);
    void setName(QString name);
    void setIsDepart(bool isDepart);
    void setHead(QString head);
    void setIsSel(bool sel);
signals:
    void idChanged(qint64 id);
    void nameChanged(QString name);
    void isDepartChanged(bool isDepart);
    void headChanged(QString head);
    void isSelChanged();
private:
    QString m_name;
    bool m_isDepart,m_isSel;
    qint64 m_id;
    QString m_head;
};

/**
 * @brief The OrgManagerNavBar class
 * 组织架构导航条列表对应model
 */
class OrgManagerNavBar : public CDoodListModel
{
    Q_OBJECT
public:
    Q_INVOKABLE void setNav(qint64 id,QString name);
    OrgManagerNavBar(QObject*parent = 0);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void test();

    virtual ~OrgManagerNavBar();

signals:
    void updateOrgList(qint64 id);
};

/**
 * @brief The OrgManager class
 * 组织架构信息列表对应model
 */
class OrgManager : public CDoodListModel
{
    Q_OBJECT
    Q_PROPERTY(qint64 id READ id)
    Q_PROPERTY(QString name READ name )

public:
    //根据json解析数据
    Q_INVOKABLE void resetDataFromJson(QString json);
    //设置数据
    Q_INVOKABLE void resetModel(qint64 id);
    Q_INVOKABLE void setSel(qint64 id);
    Q_INVOKABLE void clear();

    qint64 id();
    QString name();
    OrgManager(QObject*parent = 0);
    virtual ~OrgManager();
private:
    EnterpriseNode searchByUserId(qint64 userId);
    qint64 mSelId;
    QList<EnterpriseNode> m_data;
};

#endif // ORGMANAGER_H
