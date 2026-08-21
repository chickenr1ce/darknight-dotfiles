import QtQuick
import QtQuick.Layouts
import "../config"

// Rounded, translucent container matching waybar's #module styling.
// Emits clicked(mouse) so modules don't need their own MouseArea.
Rectangle {
    id: root

    color: Colors.background
    radius: Globals.radius
    implicitHeight: Globals.barHeight
    implicitWidth: idModuleBoxLayout.implicitWidth + 2 * Globals.modulePadding

    signal clicked(var mouse)

    default property alias content: idModuleBoxLayout.data

    RowLayout {
        id: idModuleBoxLayout

        anchors.fill: parent
        anchors.leftMargin: Globals.modulePadding
        anchors.rightMargin: Globals.modulePadding
        spacing: Globals.spacing
    }

    MouseArea {
        id: idModuleBoxMouseArea
        anchors.fill: parent
        z: 1
        onClicked: mouse => root.clicked(mouse)
    }
}
