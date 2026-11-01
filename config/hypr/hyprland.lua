-- Hyprland Lua configuration (0.55+)
-- Catppuccin Mocha palette uses hex RGB values; helpers build Hyprland colors.

local catppuccin = {
    rosewater = "f5e0dc",
    flamingo  = "f2cdcd",
    pink      = "f5c2e7",
    mauve     = "cba6f7",
    red       = "f38ba8",
    maroon    = "eba0ac",
    peach     = "fab387",
    yellow    = "f9e2af",
    green     = "a6e3a1",
    teal      = "94e2d5",
    sky       = "89dceb",
    sapphire  = "74c7ec",
    blue      = "89b4fa",
    lavender  = "b4befe",
    text      = "cdd6f4",
    subtext1  = "bac2de",
    subtext0  = "a6adc8",
    overlay2  = "9399b2",
    overlay1  = "7f849c",
    overlay0  = "6c7086",
    surface2  = "585b70",
    surface1  = "45475a",
    surface0  = "313244",
    base      = "1e1e2e",
    mantle    = "181825",
    crust     = "11111b",
}

local function rgb(hex)
    return "rgb(" .. hex .. ")"
end

local function rgba(hex, alpha)
    return "rgba(" .. hex .. alpha .. ")"
end

------------------
-- MONITORS
-- Docs: https://wiki.hypr.land/configuring/core/monitors/
------------------
-- Fallback for outputs without a more specific monitor rule.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

------------------
-- APPLICATIONS
------------------
local terminal         = "kitty"
local fileManager      = "thunar"
local menu             = "noctalia msg panel-toggle launcher"
local browser          = "brave-origin"
local minecraftLauncher = "prismlauncher"

------------------
-- AUTOSTART
------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprctl setcursor Sparkle 32")
end)

------------------
-- ENVIRONMENT
------------------
hl.env("HYPRCURSOR_THEME", "Sparkle")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Optional security hardening. Add the required hl.permission(...) rules first.
-- Enabling enforcement requires a Hyprland restart.
-- hl.config({ ecosystem = { enforce_permissions = true } })

------------------
-- APPEARANCE
-- Docs: https://wiki.hypr.land/configuring/core/config-options/
------------------
hl.config({
    general = {
        gaps_in     = 3,
        gaps_out    = 3,
        border_size = 2,
        layout      = "dwindle",
        resize_on_border = false, -- Enable to resize windows by dragging their borders.
        allow_tearing    = false, -- Keep disabled unless you specifically need tearing.
        col = {
            active_border = {
                colors = { rgb(catppuccin.mauve), rgb(catppuccin.blue) },
                angle = 45,
            },
            inactive_border = rgba(catppuccin.surface1, "99"),
            nogroup_border = rgba(catppuccin.crust, "dd"),
            nogroup_border_active = {
                colors = { rgb(catppuccin.blue), rgb(catppuccin.mauve) },
                angle = 45,
            },
        },
    },

    decoration = {
        rounding       = 5,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 0.75,
        shadow = {
            enabled      = true,
            range        = 12,
            render_power = 3,
            color        = tonumber("cc" .. catppuccin.crust, 16),
        },
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.12,
        },
    },

    animations = {
        enabled = true,
    },

    group = {
        groupbar = {
            col = {
                active = {
                    colors = { rgb(catppuccin.mauve), rgb(catppuccin.blue) },
                    angle = 45,
                },
                inactive = rgba(catppuccin.crust, "dd"),
            },
        },
    },

    dwindle = {
        preserve_split = true, -- Keep manual split proportions when managing windows.
    },

    misc = {
        force_default_wallpaper = 0,   -- Disable the default mascot wallpaper.
        disable_hyprland_logo   = true, -- Hide the Hyprland logo/mascot background.
    },

    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        repeat_rate  = 25,
        repeat_delay = 300,
        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 to 1.0; 0 leaves sensitivity unchanged.
        touchpad = {
            natural_scroll = false,
        },
    },
})

------------------
-- ANIMATIONS
-- Docs: https://wiki.hypr.land/configuring/core/animations/
------------------
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },   { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },      { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },  { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },   { 0.1, 1 } } })

-- Keep `dampening` for compatibility with stable Hyprland versions using that API field.
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  spring = "easy",    style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

------------------
-- INPUT DEVICES
------------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Device identifiers are hardware-specific; keep these matched to your devices.
local touchpadEnabled = true
local touchpadName = "elan1300:00-04f3:3057-touchpad"

hl.device({
    name        = touchpadName,
    enabled     = touchpadEnabled,
    sensitivity = -0.2,
})

hl.device({
    name        = "sigmachip-usb-mouse",
    sensitivity = -0.8,
})

------------------
-- KEYBINDINGS
-- Docs: https://wiki.hypr.land/configuring/core/binds/
------------------
local mainMod   = "SUPER"
local secondMod = mainMod .. " + SHIFT"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(minecraftLauncher))
hl.bind(secondMod .. " + S", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(secondMod .. " + Q", hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
))

-- Focus and move windows with the arrow keys.
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(secondMod .. " + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(secondMod .. " + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(secondMod .. " + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(secondMod .. " + down",  hl.dsp.window.move({ direction = "down" }))

hl.bind("F11", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("F12", function()
    touchpadEnabled = not touchpadEnabled
    hl.device({
        name        = touchpadName,
        enabled     = touchpadEnabled,
        sensitivity = -0.2,
    })
end)
hl.bind(secondMod .. " + X", hl.dsp.window.float({ action = "toggle" }))
hl.bind(secondMod .. " + Z", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Drag or resize windows with Super + mouse buttons.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio and brightness keys. Requires wpctl and brightnessctl.
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl.
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

------------------
-- WINDOW RULES
-- Docs: https://wiki.hypr.land/configuring/core/rules/window-rules/
------------------
-- Keep XWayland windows aligned with the Catppuccin palette.
hl.window_rule({
    match = { xwayland = true },
    border_color = rgb(catppuccin.blue),
})

hl.window_rule({
    match = { float = true },
    decorate = false,
})

-- Prevent applications from sending maximize requests to the compositor.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Work around focus and dragging issues with empty-title XWayland windows.
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Keep the XWayland video bridge hidden and unobtrusive.
hl.window_rule({
    name = "xwayland-video-bridge-fixes",
    match = { class = "xwaylandvideobridge" },
    no_initial_focus = true,
    no_focus         = true,
    no_anim          = true,
    no_blur          = true,
    max_size         = { 1, 1 },
    opacity          = "0.0 override",
})
