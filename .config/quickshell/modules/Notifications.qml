import QtQuick
import Quickshell.Io
import "../config"
import "../components"

// swaync toggle, mirroring the waybar custom/notification module.
ModuleBox {
  Text {
    color: Colors.lavender
    font.family: Globals.fontFamily
    font.pixelSize: Globals.fontPixelSize
    font.weight: Font.DemiBold
    text: ""
  }

  onClicked: { toggle.command = ["swaync-client", "-t", "-sw"]; toggle.running = true }
  Process { id: toggle }
}
