-- Input configuration

hl.config({
    input = {
        sensitivity = 0.30,
        -- Focus the window under the mouse pointer.
        follow_mouse = 1,
        -- Return to the most recently used window after closing one.
        focus_on_close = 2,
        float_switch_override_focus = 0,
        accel_profile = "adaptive",
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
-- Closing remains an explicit keyboard action; no accidental swipe-to-close.
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
