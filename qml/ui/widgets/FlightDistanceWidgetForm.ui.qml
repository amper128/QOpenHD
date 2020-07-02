import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import Qt.labs.settings 1.0

import OpenHD 1.0

BaseWidget {
    id: flightDistanceWidget
    width: 96
    height: 24

    visible: settings.show_flight_distance

    widgetIdentifier: "flight_distance_widget"

    defaultAlignment: 2
    defaultXOffset: 100
    defaultYOffset: 0
    defaultHCenter: false
    defaultVCenter: false

    hasWidgetDetail: true
    widgetDetailComponent: Column {
        Item {
            width: parent.width
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
                id: distance_opacity_Slider
                orientation: Qt.Horizontal
                from: .1
                value: settings.flight_distance_opacity
                to: 1
                stepSize: .1
                height: parent.height
                anchors.rightMargin: 0
                anchors.right: parent.right
                width: parent.width - 96

                onValueChanged: {
                    settings.flight_distance_opacity = distance_opacity_Slider.value
                }
            }
        }
    }

    Glow {
        anchors.fill: widgetInner
        visible: settings.show_flight_distance
        radius: 3
        samples: 17
        color: settings.color_glow
        opacity: settings.flight_distance_opacity
        source: widgetInner
    }

    Item {
        id: widgetInner

        anchors.fill: parent

        Text {
            id: home_icon
            x: 0

            width: 24
            height: 24
            clip: true
            color: settings.color_shape
            opacity: settings.distance_opacity
            text: "\uf018"
            anchors.right: flight_distance_text.left
            anchors.rightMargin: 6
            verticalAlignment: Text.AlignVCenter
            font.family: "Font Awesome 5 Free"
            styleColor: "#f7f7f7"
            font.pixelSize: 15
            horizontalAlignment: Text.AlignRight
        }

        Label {
            id: flight_distance_text
            width: 68
            height: 24
            clip: true

            color: settings.color_text
            opacity: settings.distance_opacity
            // @disable-check M222
            text: {
                var distance = OpenHD.flight_distance / 1000.0;
                var unit = "km";
                var use_imperial = settings.value("enable_imperial", false);
                // QML settings can return strings for booleans on some platforms so we check
                if (use_imperial === true || use_imperial === 1 || use_imperial === "true") {
                    unit = "mi";
                    distance /= 1.609344;
                }

                return distance.toLocaleString(Qt.locale(), "f", 1) + unit
            }
            elide: Text.ElideRight
            anchors.right: parent.right
            anchors.rightMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
        }
    }
}
