--  ▄▄▄· ▄• ▄▌▄▄▄▄▄      .▄▄ · ▄▄▄▄▄ ▄▄▄· ▄▄▄  ▄▄▄▄▄
-- ▐█ ▀█ █▪██▌•██  ▪     ▐█ ▀. •██  ▐█ ▀█ ▀▄ █·•██  
-- ▄█▀▀█ █▌▐█▌ ▐█.▪ ▄█▀▄ ▄▀▀▀█▄ ▐█.▪▄█▀▀█ ▐▀▀▄  ▐█.▪
-- ▐█ ▪▐▌▐█▄█▌ ▐█▌·▐█▌.▐▌▐█▄▪▐█ ▐█▌·▐█ ▪▐▌▐█•█▌ ▐█▌·
--  ▀  ▀  ▀▀▀  ▀▀▀  ▀█▄▀▪ ▀▀▀▀  ▀▀▀  ▀  ▀ .▀  ▀ ▀▀▀ 
--
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- 
hl.on("hyprland.start", function()
    hl.exec_cmd(
        [[wpctl set-mute "Starship/Matisse HD Audio Controller Analog Stereo" 0 && wpctl set-volume "Starship/Matisse HD Audio Controller Analog Stereo" 1]])
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start graphical-session.target")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar & awww-daemon & swaync")
    hl.exec_cmd("cursor-clip --daemon")
    hl.exec_cmd("kbuildsycoca6 --noincremental")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("spotify", {
        workspace = "7"
    })
    -- Wrapper self-heals Vencord-asr damage and forces X11 (Chromium drops XF86Launch* keys on Wayland)
    hl.exec_cmd("/home/alexiz/.local/bin/discord", {
        workspace = "6"
    })
end)
