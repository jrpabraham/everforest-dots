---------------
-- Autostart --
---------------

hl.on("hyprland.start", function () 
   hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
   hl.exec_cmd("waybar & hyprpaper & hypridle & hyprsunset & mako")
 end)

--------------
-- Monitors --
--------------

-- Set to always mirror external display

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
    mirror   = "HDMI-A-1",
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-----------------
-- Environment --
-----------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

------------------
-- Default apps --
------------------

local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "fuzzel"
local browser = "helium-browser"

-----------------
-- Keybindings --
-----------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("~/.config/fuzzel/power-menu.sh"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("xdg-terminal-exec yazi"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))

hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({"fullscreen"}))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
-- hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
-- hl.bind(mainMod .. " + J",    hl.dsp.focus({ direction = "up" }))
-- hl.bind(mainMod .. " + K",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- mainMod .. " + SHIFT + H",  hl.dsp.window.swap({ direction = "left" }))
-- mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
-- mainMod .. " + SHIFT + J",    hl.dsp.window.swap({ direction = "up" }))
-- mainMod .. " + SHIFT + K",  hl.dsp.window.swap({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Multimedia keys for volume

hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/volume-notify.sh up"),
    { locked = true, repeating = true })

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/volume-notify.sh down"),
    { locked = true, repeating = true })

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/volume-notify.sh mute"),
    { locked = true, repeating = true })

hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })

-- Multimedia keys for brightness

hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness-notify.sh up"),
    { locked = true, repeating = true })
    
hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness-notify.sh down"),
    { locked = true, repeating = true })

-- Multimedia keys for playback

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Inputs --

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0.6, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-------------
-- Windows --
-------------

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    border_size = 1,
    ["col.active_border"] = "rgba(a7c080ee)",
    ["col.inactive_border"] = "rgba(272e33aa)",
    resize_on_border = true,
    hover_icon_on_border = true,
    layout = "dwindle",
  },
  decoration = {
    rounding = 8,
    rounding_power = 2,
  },
  dwindle = {
    preserve_split = true,
  },
  misc = {
    force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- suppressMaximizeRule:set_enabled(false)

