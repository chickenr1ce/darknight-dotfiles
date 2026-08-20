import QtQuick
import Quickshell.Services.Mpris
import "../config"
import "../components"

// First non-firefox MPRIS player. Click toggles play/pause.
// "Playing" state inverts the module colors like waybar.
// Mpris.players is a QML model, not a JS array, so iterate by index.
ModuleBox {
    id: box
    property var player: null

    function refresh() {
        const m = Mpris.players;
        if (!m) {
            player = null;
            return;
        }
        player = null;
        for (let i = 0; i < m.count; i++) {
            const p = m.get(i);
            if (!(p.identity || "").toLowerCase().includes("firefox")) {
                player = p;
                break;
            }
        }
    }

    Component.onCompleted: refresh()
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: refresh()
    }

    visible: player !== null
    color: player && player.isPlaying ? Colors.lavender : Colors.background

    Text {
        color: player && player.isPlaying ? Colors.background : Colors.lavender
        font.family: Globals.fontFamily
        font.pixelSize: Globals.fontPixelSize
        font.weight: Font.DemiBold
        text: {
            if (!player)
                return "";
            const icon = player.isPlaying ? "▶" : "⏸";
            const title = player.trackTitle || "";
            const artist = player.trackArtist || "";
            return " " + icon + " " + title + (artist ? " - " + artist : "");
        }
    }

    onClicked: {
        if (player && player.playPause)
            player.playPause();
    }
}
