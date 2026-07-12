--  ▄▄▌ ▐ ▄▌      ▄▄▄  ▄ •▄ .▄▄ ·  ▄▄▄· ▄▄▄·  ▄▄· ▄▄▄ ..▄▄ · 
-- ██· █▌▐█▪     ▀▄ █·█▌▄▌▪▐█ ▀. ▐█ ▄█▐█ ▀█ ▐█ ▌▪▀▄.▀·▐█ ▀. 
-- ██▪▐█▐▐▌ ▄█▀▄ ▐▀▀▄ ▐▀▀▄·▄▀▀▀█▄ ██▀·▄█▀▀█ ██ ▄▄▐▀▀▪▄▄▀▀▀█▄
-- ▐█▌██▐█▌▐█▌.▐▌▐█•█▌▐█.█▌▐█▄▪▐█▐█▪·•▐█ ▪▐▌▐███▌▐█▄▄▌▐█▄▪▐█
--  ▀▀▀▀ ▀▪ ▀█▄▀▪.▀  ▀·▀  ▀ ▀▀▀▀ .▀    ▀  ▀ ·▀▀▀  ▀▀▀  ▀▀▀▀ 
--
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
--
--
hl.workspace_rule({
    workspace = "1",
    monitor = "DP-1",
    persistent = true,
    default = true
})

hl.workspace_rule({
    workspace = "2",
    monitor = "DP-1",
    persistent = true
})

hl.workspace_rule({
    workspace = "3",
    monitor = "DP-1",
    persistent = true
})

hl.workspace_rule({
    workspace = "4",
    monitor = "DP-1",
    persistent = true
})

hl.workspace_rule({
    workspace = "5",
    monitor = "DP-1",
    persistent = true
})

hl.workspace_rule({
    workspace = "6",
    monitor = "DP-2",
    persistent = true,
    gaps_out = "8",
    default = true
})

hl.workspace_rule({
    workspace = "7",
    monitor = "DP-2",
    persistent = true,
    gaps_out = "8"
})

hl.workspace_rule({
    workspace = "8",
    monitor = "DP-2",
    persistent = true,
    gaps_out = "8"
})

hl.workspace_rule({
    workspace = "9",
    monitor = "DP-2",
    persistent = true,
    gaps_out = "8"
})

hl.workspace_rule({
    workspace = "10",
    monitor = "DP-2",
    persistent = true,
    gaps_out = "8"
})
