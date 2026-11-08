-- Look and feel configuration
-- Border and group colors are applied by noctalia.lua and hyprland.lua.

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 8,
        border_size = 1,
        extend_border_grab_area = 10,
        resize_on_border = true,
    },
    decoration = {
        dim_special = 0.3,
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        shadow = {
            enabled = false,
        },
        blur = {
            enabled = false,
            special = false,
        },
    },
})
