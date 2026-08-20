pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "config"
import "modules"

// Quickshell panel config.
// One PanelWindow per connected screen (Variants over Quickshell.screens).
// Left:  Clock (+ monitor name placeholder)
// Right: Mpris, Audio, Cpu, Notifications, PowerMenu  (DP-1 only for now)
// Workspaces / People / Tray / visualizer land in a later pass.

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        // qmllint disable uncreatable-type
        PanelWindow {
            id: idPanel

            required property var modelData
            screen: modelData
            property string monName: modelData.name

            anchors.top: true
            anchors.left: true
            anchors.right: true
            implicitHeight: Globals.barHeight + Globals.moduleMargin
            color: "transparent"

            RowLayout {
                anchors.fill: parent

                anchors.leftMargin: Globals.horizontalBarMargin
                anchors.rightMargin: Globals.horizontalBarMargin
                anchors.topMargin: Globals.moduleMargin
                //anchors.bottomMargin: Globals.moduleMargin

                spacing: Globals.moduleMargin

                // Left cluster
                Clock {}

                Rectangle {
                    Layout.fillWidth: true
                    color: "transparent"
                }

                // Right cluster (full bar only)
                Media {
                    visible: idPanel.monName === "DP-1"
                }
                Audio {
                    visible: idPanel.monName === "DP-1"
                }
                Cpu {
                    visible: idPanel.monName === "DP-1"
                }
                Notifications {
                    visible: idPanel.monName === "DP-1"
                }
                PowerMenu {
                    visible: idPanel.monName === "DP-1"
                }
            }
        }
    }
}
