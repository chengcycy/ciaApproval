#ifndef CONTACTDEF_H
#define CONTACTDEF_H
#include <QString>
class OrgUser{
public:
    OrgUser(){orgName="";orgID=0;}

    QString orgName;
    qint64  orgID;
};

class StaffUser{
public:
    StaffUser(){userPhotoUrl = userName="";userID=0;}

    QString userPhotoUrl;
    QString userName;
    qint64  userID;
};

class EnterpriseNode{
public:
    EnterpriseNode(){userName="";userID=0;}

    QList<StaffUser> staffList;
    QList<OrgUser> orgList;

    QString userName;
    qint64  userID;
};

#endif // CONTACTDEF_H
