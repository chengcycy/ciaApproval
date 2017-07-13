#ifndef CUTILLS_H
#define CUTILLS_H

#include <QObject>
#include <QScreen>
#include <QGuiApplication>

class CUtills : public QObject
{
    Q_OBJECT

    enum{
        BASE_WIDTH = 720,
        BASE_HEIGHT = 1184,
        BASE_DP = 220,
        BASE_DP2 = 442
    };
public:
    explicit CUtills(QObject *parent = 0);

signals:

public slots:
    int dpH(int h);
    int dpW(int w);
    int dpH2(int h);
    int dpW2(int w);
    int deviceType();
private:
    float  mPixeDens;
    float  mDefaultW,mDefaultH;
};

#endif // CUTILLS_H
