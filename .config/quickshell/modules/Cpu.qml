import QtQuick
import Quickshell.Io
import "../config"
import "../components"

// CPU usage from /proc/stat, polled every 2s.
ModuleBox {
  id: box
  property real usage: 0
  property var last: null

  Text {
    color: Colors.lavender
    font.family: Globals.fontFamily
    font.pixelSize: Globals.fontPixelSize
    font.weight: Font.DemiBold
    text: Math.round(box.usage) + "% "
  }

  Process {
    id: cpuProc
    command: ["bash", "-c", "grep '^cpu ' /proc/stat"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const parts = this.text.trim().split(/\s+/).slice(1).map(Number)
        const idle = parts[3]
        const total = parts.reduce((a, b) => a + b, 0)
        if (box.last !== null) {
          const dTotal = total - box.last.total
          const dIdle = idle - box.last.idle
          const u = dTotal > 0 ? (1 - dIdle / dTotal) * 100 : 0
          box.usage = Math.max(0, Math.min(100, u))
        }
        box.last = { total, idle }
      }
    }
  }

  Timer { interval: 2000; running: true; repeat: true; onTriggered: cpuProc.running = true }
}
