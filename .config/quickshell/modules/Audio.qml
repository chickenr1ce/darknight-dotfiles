import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Io
import "../config"
import "../components"

// Volume from the default Pipewire sink.
// Left-click cycles the three named sinks (replaces toggle_audio.sh).
// Right-click opens pavucontrol.
ModuleBox {
  id: box
  property var sink: Pipewire.defaultAudioSink

  Text {
    color: Colors.lavender
    font.family: Globals.fontFamily
    font.pixelSize: Globals.fontPixelSize
    font.weight: Font.DemiBold
    text: {
      if (!box.sink) return ""
      const vol = Math.round((box.sink.volume ?? 1) * 100)
      return (box.sink.muted ? " " : " ") + vol + "%"
    }
  }

  onClicked: (mouse) => {
    if (mouse.button === Qt.RightButton) openMixer()
    else cycleSink()
  }

  function cycleSink() {
    const order = ["JadeAudio", "AB13X", "Pebble"]
    const cur = box.sink ? (box.sink.description || box.sink.name || "") : ""
    let idx = -1
    for (let i = 0; i < order.length; i++)
      if (cur.includes(order[i])) idx = i
    const next = order[(idx + 1) % order.length]
    for (const n of Pipewire.nodes) {
      const label = n.description || n.name || ""
      if (label.includes(next)) {
        setDefault.command = ["wpctl", "set-default", String(n.id)]
        setDefault.running = true
        return
      }
    }
  }

  function openMixer() { mixer.command = ["pavucontrol"]; mixer.running = true }

  Process { id: setDefault }
  Process { id: mixer }
}
