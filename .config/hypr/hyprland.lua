-- CachyOS Hyprland Configuration

require("config.animations")
require("config.autostart")
require("config.colors")
require("config.decorations")
require("config.variables")
require("config.environment")
require("config.inputs")
require("config.binds")
require("config.misc")
require("config.monitors")
require("config.lock_display_recovery")
require("config.windowrules")
require("config.workspaces")


-- For Noctalia Color templates
require("noctalia").apply_theme()

-- Keep the outer window frame steady when mouse hover changes focus.
-- Apply after the theme so generated colors cannot override this preference.
hl.config({
    general = {
        col = {
            active_border = "rgb(36465f)",
            inactive_border = "rgb(36465f)",
        },
    },
})
