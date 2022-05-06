/*
 * Copyright (C) 2022  Ivo Xavier
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * fajitatweaks is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Controls 2.2 as QQC2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'fajitatweaks.ivoxavier'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property bool is_doubleTap_enabled

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('fajitaTweaks')
        }

        ColumnLayout{            
            anchors.top: parent.header.bottom
            width: parent.width

            Label{
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: i18n.tr("Click the switch to enable/disable the double tap. It's not permanent a mod.")
            }

            Item{height: units.gu(4)}

            QQC2.Switch{
                id: doubleTap_state_switch
                Layout.alignment: Qt.AlignCenter
                checked: root.is_doubleTap_enabled
                onClicked:{
                    if(root.is_doubleTap_enabled){
                        python.call('fajita_tweaks.Tweaks.doubleTap',["0"], function(returnValue) {})
                    } else{
                        python.call('fajita_tweaks.Tweaks.doubleTap',["1"], function(returnValue) {})
                    }
                }
            }

        }
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));
            importModule('fajita_tweaks', function() {
                python.call('fajita_tweaks.Tweaks.readState', [] ,function(returnValue){
                    root.is_doubleTap_enabled = (returnValue == 1 ? true : false)
            })
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
