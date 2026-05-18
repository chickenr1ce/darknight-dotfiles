-- ▄▄▌ ▐ ▄▌▪   ▐ ▄ ·▄▄▄▄        ▄▄▌ ▐ ▄▌▄▄▄  ▄• ▄▌▄▄▌  ▄▄▄ ..▄▄ · 
-- ██· █▌▐███ •█▌▐███▪ ██ ▪     ██· █▌▐█▀▄ █·█▪██▌██•  ▀▄.▀·▐█ ▀. 
-- ██▪▐█▐▐▌▐█·▐█▐▐▌▐█· ▐█▌ ▄█▀▄ ██▪▐█▐▐▌▐▀▀▄ █▌▐█▌██▪  ▐▀▀▪▄▄▀▀▀█▄
-- ▐█▌██▐█▌▐█▌██▐█▌██. ██ ▐█▌.▐▌▐█▌██▐█▌▐█•█▌▐█▄█▌▐█▌▐▌▐█▄▄▌▐█▄▪▐█
--  ▀▀▀▀ ▀▪▀▀▀▀▀ █▪▀▀▀▀▀•  ▀█▄▀▪ ▀▀▀▀ ▀▪.▀  ▀ ▀▀▀ .▀▀▀  ▀▀▀  ▀▀▀▀ 
--
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--
-- 
local suppressMaximizeRule = hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*"
    },
    suppress_event = "maximize"
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false
    },
    no_focus = true
})

hl.window_rule({
    name = "move-hyprland-run",
    match = {
        class = "hyprland-run"
    },

    move = "20 monitor_h-120",
    float = true
})

hl.window_rule({
    name = "xwayland-video-bridge-fixes",
    match = {
        class = "xwaylandvideobridge"
    },

    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = "1 1",
    opacity = "0.0"
})

hl.window_rule({
    name = "steam-friends-float",
    match = {
        class = "^(steam)$",
        title = "^(Friends List)$"
    },
    float = on,
    size = "300 600",
    center = on
})

hl.window_rule({
    name = "eldenring_unstable_fps_fix",
    match = {
        class = "^(steam_app_1245620)$"
    },
    render_unfocused = on,
    idle_inhibit = "always"
})

hl.window_rule({
    name = "opacity",
    match = {
        class = "^(kitty)$"
    },
    opacity = "0.9"
})
