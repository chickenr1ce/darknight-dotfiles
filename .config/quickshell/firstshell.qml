import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "config"
import "modules"

// Quickshell panel config.
// One PanelWindow per connected screen (Variants).
// Left:  Clock (+ monitor name placeholder)
// Right: Mpris, Audio, Cpu, Notifications, PowerMenu  (DP-1 only for now)
// Workspaces / ActiveWindow / Tray / visualizer land in a later pass.

// qmllint disable uncreatable-type
PanelWindow {
    required property var modelData
    screen: modelData
    property string monName: modelData.name

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: Globals.barHeight
    color: "white"

    Text {
        id: idClock

        anchors.centerIn: parent

        Process {
            id: idDateProcess

            command: ["date"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: idClock.text = this.text
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: idDateProcess.running = true
        }
    }
}
