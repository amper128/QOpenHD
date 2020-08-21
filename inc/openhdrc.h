#ifndef RC_H
#define RC_H

#include <QObject>
#include <QtQuick>
#if defined(ENABLE_SPEECH)
#include <QtTextToSpeech/QTextToSpeech>
#endif

#if defined(ENABLE_GAMEPADS)
#include <QGamepad>
#endif

#if defined(ENABLE_JOYSTICKS)
#include <QJoysticks.h>
#endif

class QUdpSocket;

class OpenHDRC: public QObject {
    Q_OBJECT

public:
    explicit OpenHDRC(QObject *parent = nullptr);

    Q_INVOKABLE void setGroundIP(QString address);


#if defined(ENABLE_GAMEPADS)
    Q_PROPERTY(int connectedGamepad MEMBER m_selectedGamepad WRITE set_selectedGamepad NOTIFY selectedGamepadChanged)
    void set_selectedGamepad(int selectedGamepad);

    Q_PROPERTY(QString selectedGamepadName MEMBER m_selectedGamepadName WRITE set_selectedGamepadName NOTIFY selectedGamepadNameChanged)
    void set_selectedGamepadName(QString selectedGamepadName);
#endif

#if defined(ENABLE_JOYSTICKS)
    Q_PROPERTY(int connectedJoystick MEMBER m_selectedJoystick WRITE set_selectedJoystick NOTIFY selectedJoystickChanged)
    void set_selectedJoystick(int selectedJoystick);

    Q_PROPERTY(QString selectedJoystickName MEMBER m_selectedJoystickName WRITE set_selectedJoystickName NOTIFY selectedJoystickNameChanged)
    void set_selectedJoystickName(QString selectedJoystickName);
#endif



    Q_PROPERTY(uint rc1 MEMBER m_rc1 WRITE set_rc1 NOTIFY rc1_changed)
    void set_rc1(uint rc1);

    Q_PROPERTY(uint rc2 MEMBER m_rc2 WRITE set_rc2 NOTIFY rc2_changed)
    void set_rc2(uint rc2);

    Q_PROPERTY(uint rc3 MEMBER m_rc3 WRITE set_rc3 NOTIFY rc3_changed)
    void set_rc3(uint rc3);

    Q_PROPERTY(uint rc4 MEMBER m_rc4 WRITE set_rc4 NOTIFY rc4_changed)
    void set_rc4(uint rc4);

signals:
    void channelUpdate(uint rc1,
		       uint rc2,
		       uint rc3,
		       uint rc4);

    void rc1_changed(uint rc1);
    void rc2_changed(uint rc2);
    void rc3_changed(uint rc3);
    void rc4_changed(uint rc4);

#if defined(ENABLE_GAMEPADS)
    void selectedGamepadChanged(int selectedGamepad);
    void selectedGamepadNameChanged(QString selectedGamepadName);
#endif

#if defined(ENABLE_JOYSTICKS)
    void selectedJoystickChanged(int selectedJoystick);
    void selectedJoystickNameChanged(QString selectedJoystickName);
#endif


private slots:
    void channelTrigger();
#if defined(ENABLE_GAMEPADS)
    void connectedGamepadsChanged();
    void nameChanged(QString name);
#endif

#if defined(ENABLE_JOYSTICKS)
    void connectedJoysticksChanged();
#endif
    void processRCDatagrams();

    void axisChanged (const int js, const int axis, const qreal value);
    void buttonChanged(const int js, const int button, const bool pressed);

    void connectedChanged(bool value);
    void axisLeftXChanged(double value);
    void axisLeftYChanged(double value);
    void axisRightXChanged(double value);
    void axisRightYChanged(double value);
    void buttonAChanged(bool value);
    void buttonBChanged(bool value);
    void buttonXChanged(bool value);
    void buttonYChanged(bool value);
    void buttonL1Changed(bool value);
    void buttonR1Changed(bool value);
    void buttonL2Changed(double value);
    void buttonR2Changed(double value);
    void buttonSelectChanged(bool value);
    void buttonStartChanged(bool value);
    void buttonL3Changed(bool value);
    void buttonR3Changed(bool value);
    void buttonUpChanged(bool value);
    void buttonDownChanged(bool value);
    void buttonLeftChanged(bool value);
    void buttonRightChanged(bool value);
    void buttonCenterChanged(bool value);
    void buttonGuideChanged(bool value);

private:
    QUdpSocket *rcSocket = nullptr;

    QString groundAddress;

#if defined(ENABLE_GAMEPADS)
    QList<int> m_connectedGamepads;
    int m_selectedGamepad = -1;
    QGamepad *currentGamepad = nullptr;
    QString m_selectedGamepadName;
#endif


#if defined(ENABLE_JOYSTICKS)
    QList<int> m_connectedJoysticks;
    int m_selectedJoystick = -1;
    QJoystickDevice *currentJoystick = nullptr;
    QString m_selectedJoystickName;
#endif

#if defined(ENABLE_SPEECH)
    QTextToSpeech *m_speech;
#endif

    uint8_t  seqno = 0;

    uint m_rc1 = 1500;
    uint m_rc2 = 1500;
    uint m_rc3 = 1500;
    uint m_rc4 = 1500;

    uint16_t btn_map[4] = {0, 0, 0, 0};

};

#endif //RC_H
