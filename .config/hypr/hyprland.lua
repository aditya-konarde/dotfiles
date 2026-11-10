-- CachyOS Hyprland Configuration

require("config.animations")
require("config.autostart")
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
require("config.workspace_reconnect")


-- For Noctalia Color templates
require("noctalia").apply_theme()

-- Keep the outer window frame steady when mouse hover changes focus.
-- Apply after the theme so generated colors cannot override this preference.
hl.config({
    general = {
        col = {
            -- Dim on purpose: a static border is a burn-in risk on OLED.
            active_border = "rgb(232d3d)",
            inactive_border = "rgb(232d3d)",
        },
    },
})

