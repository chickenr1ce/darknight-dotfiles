import QtQuick
import QtQuick.Layouts
import "../config"

// Rounded, translucent container matching waybar's #module styling.
// Emits `clicked(mouse)` for the whole box so modules don't need their own MouseArea.
Rectangle {
    id: root

    color: Colors.background
    radius: Globals.radius
    implicitHeight: Globals.barHeight

    signal clicked(var mouse)

    default property alias content: row.data

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.leftMargin: Globals.modulePadding
        anchors.rightMargin: Globals.modulePadding
        spacing: Globals.spacing
    }

    MouseArea {
        anchors.fill: parent
        z: 1
        onClicked: mouse => root.clicked(mouse)
    }

    implicitWidth: row.implicitWidth + 2 * Globals.modulePadding
}
