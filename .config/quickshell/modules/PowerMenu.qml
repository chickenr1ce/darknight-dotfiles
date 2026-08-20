import QtQuick
import Quickshell.Io
import "../config"
import "../components"

// Power menu: launches the existing rofi powermenu script.
ModuleBox {
  Text {
    color: Colors.lavender
    font.family: Globals.fontFamily
    font.pixelSize: 13
    text: "󰐥"
  }

  onClicked: { pm.command = ["/home/alexiz/.config/rofi/powermenu/type-1/powermenu.sh"]; pm.running = true }
  Process { id: pm }
}
