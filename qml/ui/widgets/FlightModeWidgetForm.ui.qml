import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import Qt.labs.settings 1.0

import OpenHD 1.0

import "../elements"

BaseWidget {
    id: flightModeWidget
    width: 212
    height: 48

    visible: settings.show_flight_mode

    widgetIdentifier: "flight_mode_widget"

    defaultAlignment: 3
    defaultHCenter: true
    defaultVCenter: false

    hasWidgetDetail: true
    hasWidgetAction: true //--TURN TO TRUE TO SEE THE FLIGHT MODE ACTIONS
    widgetDetailComponent: ScrollView{

        //contentHeight: horizonSettingsColumn.height
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true

        ColumnLayout{
            Item {
                width: 230
                height: 32
                Text {
                    id: opacityTitle
                    text: qsTr("Transparency")
                    color: "white"
                    height: parent.height
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                }
                Slider {
                    id: flight_mode_opacity_Slider
                    orientation: Qt.Horizontal
                    from: .1
                    value: settings.flight_mode_opacity
                    to: 1
                    stepSize: .1
                    height: parent.height
                    anchors.rightMargin: 0
                    anchors.right: parent.right
                    width: parent.width - 96

                    onValueChanged: {
                        settings.flight_mode_opacity = flight_mode_opacity_Slider.value
                    }
                }
            }
            Item {
                width: 230
                height: 32
                Text {
                    text: qsTr("Size")
                    color: "white"
                    height: parent.height
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                }
                Slider {
                    id: flight_mode_size_Slider
                    orientation: Qt.Horizontal
                    from: .5
                    value: settings.flight_mode_size
                    to: 3
                    stepSize: .1
                    height: parent.height
                    anchors.rightMargin: 0
                    anchors.right: parent.right
                    width: parent.width - 96

                    onValueChanged: {
                        settings.flight_mode_size = flight_mode_size_Slider.value
                    }
                }
            }
            Item {
                width: 230
                height: 32
                Text {
                    text: qsTr("Lock to Horizontal Center")
                    color: "white"
                    height: parent.height
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                }
                Switch {
                    width: 32
                    height: parent.height
                    anchors.rightMargin: 6
                    anchors.right: parent.right
                    checked: {
                        // @disable-check M222
                        var _hCenter = settings.value(hCenterIdentifier, defaultHCenter)
                        // @disable-check M223
                        if (_hCenter === "true" || _hCenter === 1 || _hCenter === true) {
                            checked = true;
                            // @disable-check M223
                        } else {
                            checked = false;
                        }
                    }

                    onCheckedChanged: settings.setValue(hCenterIdentifier, checked)
                }
            }
            Item {
                width: 230
                height: 32
                Text {
                    text: qsTr("Lock to Vertical Center")
                    color: "white"
                    height: parent.height
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                }
                Switch {
                    width: 32
                    height: parent.height
                    anchors.rightMargin: 6
                    anchors.right: parent.right
                    checked: {
                        // @disable-check M222
                        var _vCenter = settings.value(vCenterIdentifier, defaultVCenter)
                        // @disable-check M223
                        if (_vCenter === "true" || _vCenter === 1 || _vCenter === true) {
                            checked = true;
                            // @disable-check M223
                        } else {
                            checked = false;
                        }
                    }

                    onCheckedChanged: settings.setValue(vCenterIdentifier, checked)
                }
            }
            Item {
                width: 230
                height: 32
                Text {
                    text: qsTr("Lock to Horizontal Center")
                    color: "white"
                    height: parent.height
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                }
                Switch {
                    width: 32
                    height: parent.height
                    anchors.rightMargin: 6
                    anchors.right: parent.right
                    checked: {
                        // @disable-check M222
                        var _hCenter = settings.value(hCenterIdentifier, defaultHCenter)
                        // @disable-check M223
                        if (_hCenter === "true" || _hCenter === 1 || _hCenter === true) {
                            checked = true;
                            // @disable-check M223
                        } else {
                            checked = false;
                        }
                    }

                    onCheckedChanged: settings.setValue(hCenterIdentifier, checked)
                }
            }
            Item {
                width: 230
                height: 32
                Text {
                    text: qsTr("Lock to Vertical Center")
                    color: "white"
                    height: parent.height
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                }
                Switch {
                    width: 32
                    height: parent.height
                    anchors.rightMargin: 6
                    anchors.right: parent.right
                    checked: {
                        // @disable-check M222
                        var _vCenter = settings.value(vCenterIdentifier, defaultVCenter)
                        // @disable-check M223
                        if (_vCenter === "true" || _vCenter === 1 || _vCenter === true) {
                            checked = true;
                            // @disable-check M223
                        } else {
                            checked = false;
                        }
                    }

                    onCheckedChanged: settings.setValue(vCenterIdentifier, checked)
                }
            }
        }
    }


    //---------------------------ACTION WIDGET COMPONENT BELOW-----------------------------

    widgetActionComponent: ScrollView{

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true

        /*
        PLANE_MODE_MANUAL=0,
        PLANE_MODE_CIRCLE=1,
        PLANE_MODE_STABILIZE=2,
        PLANE_MODE_TRAINING=3,
        PLANE_MODE_ACRO=4,
        PLANE_MODE_FLY_BY_WIRE_A=5,
        PLANE_MODE_FLY_BY_WIRE_B=6,
        PLANE_MODE_CRUISE=7,
        PLANE_MODE_AUTOTUNE=8,
        PLANE_MODE_AUTO=10,
        PLANE_MODE_RTL=11,
        PLANE_MODE_LOITER=12,
        PLANE_MODE_TAKEOFF=13

       COPTER_MODE_STABILIZE=0
       COPTER_MODE_ACRO=1
       COPTER_MODE_ALT_HOLD=2
       COPTER_MODE_AUTO=3
       COPTER_MODE_GUIDED=4
       COPTER_MODE_LOITER=5
       COPTER_MODE_RTL=6
       COPTER_MODE_CIRCLE=7
       COPTER_MODE_LAND=9
       COPTER_MODE_DRIFT=11
       COPTER_MODE_SPORT=13
       COPTER_MODE_FLIP=14
       COPTER_MODE_AUTOTUNE=15
       COPTER_MODE_POSHOLD=16
       COPTER_MODE_BRAKE=17
       COPTER_MODE_THROW=18
       COPTER_MODE_AVOID_ADSB=19
       COPTER_MODE_GUIDED_NOGPS=20
       COPTER_MODE_SMART_RTL=21
*/

        Column{
            width:200
            spacing: 10

            Text {
                id: name
                text: qsTr("Vehicle type: "+OpenHD.mav_type)
                color: "white"
                font.bold: true
                font.pixelSize: detailPanelFontPixels
                anchors.left: parent.left
            }

            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUPLANE"

                text_off: qsTr("RTL")
                msg_id: 11

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUPLANE"

                text_off: qsTr("MANUAL")
                msg_id: 0

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUPLANE"

                text_off: qsTr("STABILIZE")
                msg_id: 2

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUPLANE"

                text_off: qsTr("LOITER")
                msg_id: 12

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUPLANE"

                text_off: qsTr("FBWA")
                msg_id: 5

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUPLANE"

                text_off: qsTr("AUTO")
                msg_id: 10

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUPLANE"

                text_off: qsTr("AUTOTUNE")
                msg_id: 8

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }

 //-----------------------Split from plane to copter
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUCOPTER"

                text_off: qsTr("RTL")
                msg_id: 6

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUCOPTER"

                text_off: qsTr("STABILIZE")
                msg_id: 0

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUCOPTER"

                text_off: qsTr("ALT_HOLD")
                msg_id: 2

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUCOPTER"

                text_off: qsTr("LOITER")
                msg_id: 5

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUCOPTER"

                text_off: qsTr("POSHOLD")
                msg_id: 16

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUCOPTER"

                text_off: qsTr("AUTO")
                msg_id: 3

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            ConfirmSlider {

                visible: OpenHD.mav_type=="ARDUCOPTER"

                text_off: qsTr("AUTOTUNE")
                msg_id: 15

                onCheckedChanged:{
                    if (checked==true){ //double check.... not really needed

                        OpenHD.set_Requested_Flight_Mode(msg_id);
                        //console.log("selected");
                    }
                }
            }
            /*

            Column{//needs this column or buttons dont select
                id:flightmodeButtonColumn

                ButtonGroup {
                    buttons: flightmodeButtonColumn.children

                }

                RadioButton {
                    id: control
                    width: 230
                    contentItem: Text {
                        text: qsTr("Manual")
                        //font: control.font
                        //opacity: enabled ? 1.0 : 0.3
                        color: "white"

                        height: parent.height
                        font.bold: true
                        //font.pixelSize: detailPanelFontPixels
                        anchors.verticalCenter: parent.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.left: parent.left

                    }

                    indicator: Rectangle {
                        implicitWidth: 28
                        implicitHeight: 28
                        x: 160
                        y: parent.height / 2 - height / 2
                        radius: 16
                        color: "transparent"
                        border.color: control.down ? "#15a4ef" : "#ffffff"

                        Rectangle {
                            width: 16
                            height: 16
                            x: 6
                            y: 6
                            radius: 8
                            color: "#15a4ef"
                            visible: control.checked
                        }
                    }
                    onCheckedChanged: {
                        OpenHD.set_Requested_Flight_Mode(0);
                    }
                }
            }
            */
        }
    }

    Item {
        id: widgetInner
        anchors.fill: parent
        scale: settings.flight_mode_size



        Text {
            id: flight_mode_icon
            width: 24
            height: 48
            color: settings.color_shape
            opacity: settings.flight_mode_opacity
            text: "\uf072"
            anchors.right: flight_mode_text.left
            anchors.rightMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Font Awesome 5 Free"
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            style: Text.Outline
            styleColor: settings.color_glow
        }

        Label {
            id: flight_mode_text
            height: 48
            color: settings.color_text
            opacity: settings.flight_mode_opacity
            text: OpenHD.armed ? "["+OpenHD.flight_mode+"]" : OpenHD.flight_mode
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 24
            font.family: settings.font_text
            elide: Text.ElideRight
            style: Text.Outline
            styleColor: settings.color_glow
        }
    }
}
