#include "cutills.h"
#include <QDebug>

CUtills::CUtills(QObject *parent) : QObject(parent)
{
    mPixeDens = 4.46*3.375;
    mDefaultW = 1.0 * QGuiApplication::primaryScreen()->availableSize().width()/BASE_WIDTH;
    mDefaultH = 1.0 * QGuiApplication::primaryScreen()->availableSize().height()/BASE_HEIGHT;
}

int CUtills::dpH(int h)
{
    int tmp =  ((h*((mPixeDens*25.4)/BASE_DP*mDefaultH)))+0.5;
    return tmp;
}

int CUtills::dpW(int w)
{

    return (w*((mPixeDens*25.4)/BASE_DP*mDefaultW)+0.5);
}

int CUtills::dpH2(int h)
{
    int dp = QGuiApplication::primaryScreen()->physicalDotsPerInch();
    if(dp == BASE_DP2){
        return dpH(h/2);
    }
    return h;
}

int CUtills::dpW2(int w)
{
    int dp = QGuiApplication::primaryScreen()->physicalDotsPerInch();
    if(dp == BASE_DP2){
        return dpH(w/2);
    }
    return w;
}

int CUtills::deviceType()
{
    QScreen * screen = QGuiApplication::primaryScreen();
    int virtualSize = screen->virtualSize().width();

    if(virtualSize == 1080){
        return 1;//小辣椒
    }else{
        return 2;//老机子
    }
}
