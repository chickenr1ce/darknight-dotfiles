import QtQuick
import "../config"
import "../components"

ModuleBox {
  Text {
    id: clockText
    color: Colors.lavender
    font.family: Globals.fontFamily
    font.pixelSize: Globals.fontPixelSize
    font.weight: Font.DemiBold
    text: Qt.formatDateTime(new Date(), "dd.MM hh:mm")

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: clockText.text = Qt.formatDateTime(new Date(), "dd.MM hh:mm")
    }
  }
}
