#include "orgmanager.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonParseError>
#include <QDebug>
#include <QFile>
void OrgManager::resetDataFromJson(QString json)
{
    clear();
    m_data.clear();

    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(json.toUtf8().data(),&err);
    if(err.error == QJsonParseError::NoError){
        QJsonArray demoOrg = doc.object().value("demoOrg").toArray();
        for(auto iter:demoOrg){
            EnterpriseNode node;
            node.userID = iter.toObject().value("userID").toDouble();
            node.userName = iter.toObject().value("userName").toString();

            QJsonArray orgList = iter.toObject().value("orgList").toArray();
            for(auto org:orgList){
                OrgUser orgUser;
                orgUser.orgID = org.toObject().value("orgID").toDouble();
                orgUser.orgName = org.toObject().value("orgName").toString();
                node.orgList.push_back(orgUser);
            }

            QJsonArray staffList = iter.toObject().value("staffList").toArray();
            for(auto staff:staffList){
                StaffUser staffUser;
                staffUser.userID = staff.toObject().value("userID").toDouble();
                staffUser.userName = staff.toObject().value("userName").toString();
                staffUser.userPhotoUrl = staff.toObject().value("userPhotoUrl").toString();
                node.staffList.push_back(staffUser);
            }
            m_data.push_back(node);
        }
    }

}

void OrgManager::resetModel(qint64 id)
{
    reset();
    EnterpriseNode node = searchByUserId(id);
    //org
    for(auto org : node.orgList){
        OrgItem* item = new OrgItem(this);
        item->setId(org.orgID);
        item->setName(org.orgName);
        item->setIsDepart(true);
        addItem(item);
        qDebug()<<Q_FUNC_INFO<<"name:"<<item->name();
    }
    //user
    for(auto staff : node.staffList){
        OrgItem* item = new OrgItem(this);
        item->setId(staff.userID);
        item->setName(staff.userName);
        item->setIsDepart(false);
        item->setHead(staff.userPhotoUrl);
        if(staff.userID == mSelId){
            item->setIsSel(true);
        }else{
            item->setIsSel(false);
        }
        addItem(item);
    }

}

void OrgManager::setSel(qint64 id)
{
    mSelId = id;
    for(int i = 0;i<_list->size();i++){
        OrgItem* iter = (OrgItem*)_list->at(i);
        if(iter != NULL && iter->id() == id){
           iter->setIsSel(true);
        }else{
            iter->setIsSel(false);
        }
    }
}

void OrgManager::clear()
{
    reset();
    mSelId = 0;
}

QString OrgManager::nameById(qint64 id)
{
    return searchByUserId(id).userName;
}

qint64 OrgManager::id()
{
    return mSelId;
}

QString OrgManager::name()
{
    for(int j = 0;j<_list->size();j++){
        OrgItem* item = (OrgItem*)get(j);
        if(item!= NULL && item->id() == mSelId){
           return item->name();
        }
    }
    return "";
}

OrgManager::OrgManager(QObject*parent):CDoodListModel(parent)
{
    qRegisterMetaType<OrgManager*>();
    mSelId = 0;
    //test
//    QFile file(DATA_CONFIG_FILE);
//    if(file.open(QIODevice::ReadOnly)){
//        resetDataFromJson(file.readAll());
//        file.close();
//    }
}

OrgManager::~OrgManager()
{
    reset();
}

EnterpriseNode OrgManager::searchByUserId(qint64 userId)
{
    for(auto i:m_data){
        if(i.userID == userId){
            return i;
        }
    }
    return EnterpriseNode();
}

OrgItem::OrgItem(QObject *parent):QObject(parent)
{
    m_id = 0;
    m_name = "";
    m_head = "";
    m_isDepart = true;

    qRegisterMetaType<OrgItem*>();
}

OrgItem::~OrgItem()
{
    qDebug()<<Q_FUNC_INFO;
}

qint64 OrgItem::id() const
{
    return m_id;
}

QString OrgItem::name() const
{
    return m_name;
}

bool OrgItem::isDepart() const
{
    return m_isDepart;
}

QString OrgItem::head() const
{
    return m_head;
}

bool OrgItem::isSel()
{
    return m_isSel;
}
void OrgItem::setId(qint64 id)
{
    if (m_id == id)
        return;

    m_id = id;
    emit idChanged(id);
}

void OrgItem::setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(name);
}

void OrgItem::setIsDepart(bool isDepart)
{
    if (m_isDepart == isDepart)
        return;

    m_isDepart = isDepart;
    emit isDepartChanged(isDepart);
}
void OrgItem::setHead(QString head)
{
    if (m_head == head)
        return;

    m_head = head;
    emit headChanged(head);
}

void OrgItem::setIsSel(bool sel)
{
    m_isSel = sel;
    emit isSelChanged();
}

void OrgManagerNavBar::setNav(qint64 id,QString name)
{
    bool hasItem = false;
    bool index = 0;
    for(int i = 0;i<_list->size();i++){
        OrgItem* item = (OrgItem*)_list->at(i);
        if(item != NULL && item->id() == id){
            item->setIsSel(true);
            index = i;
            hasItem = true;
        }else if(item != NULL && item->id() != id){
            item->setIsSel(false);
        }
    }
    if(!hasItem){
        OrgItem* item = new OrgItem(this);
        item->setId(id);
        item->setName(name);
        item->setIsDepart(true);
        item->setIsSel(true);
        addItem(item);
    }else{
       //delete
        for(int j = index+1;j<_list->size();j++){
            OrgItem* item = (OrgItem*)get(j);
            if(item!= NULL && item->id() != id){
                removeItem(item);
                delete item;
            }
        }
    }
    emit updateOrgList(id);
}

OrgManagerNavBar::OrgManagerNavBar(QObject *parent):CDoodListModel(parent)
{
    qRegisterMetaType<OrgManagerNavBar*>();
//    setNav(1,"中国科学院");
}

void OrgManagerNavBar::clear()
{
    reset();
}

void OrgManagerNavBar::test()
{
//    setNav(1,"中国科学院");
}

OrgManagerNavBar::~OrgManagerNavBar()
{
    reset();
}
