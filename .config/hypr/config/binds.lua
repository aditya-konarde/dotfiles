-- Described binding catalog. No theme-generated file owns this behavior.
local catalog = {}
local seen = {}
local function bind(description, key, action, options)
    assert(not seen[key], "Duplicate shortcut: " .. key)
    seen[key] = true
    options = options or {}
    options.description = description
    catalog[#catalog + 1] = { key = key, description = description }
    hl.bind(key, action, options)
end
local home = os.getenv("HOME")
local mainMod = "SUPER"
local noctCall = "noctalia msg "
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

-- Window manipulation
bind("Hyprland kill selector", mainMod .. " + Escape",      hl.dsp.exec_cmd("hyprctl kill"))
bind("Close window", mainMod .. " + Q",           hl.dsp.window.close())
bind("Toggle floating", mainMod .. " + ALT + Space", hl.dsp.window.float({ action = "toggle" }))
bind("Toggle fullscreen", mainMod .. " + ALT + D",           hl.dsp.window.fullscreen({ mode = 1 }))
bind("Toggle fullscreen", mainMod .. " + ALT + F", hl.dsp.window.fullscreen())
bind("Toggle split", mainMod .. " + ALT + J",           hl.dsp.layout("togglesplit"))

-- Change focus
bind("Focus window / workspace", mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
bind("Focus window / workspace", mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
bind("Focus window / workspace", mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
bind("Focus window / workspace", mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))
bind("Window switcher", "ALT + Tab", hl.dsp.exec_cmd(noctCall .. "window-switcher hold"))
bind("Window switcher", mainMod .. " + Tab", hl.dsp.exec_cmd(noctCall .. "window-switcher hold"))
bind("Window switcher", mainMod .. " + SHIFT + Tab", hl.dsp.exec_cmd(noctCall .. "window-switcher hold"))

-- Move active window around workspaces & monitors
bind("Move window", mainMod .. " + SHIFT + Up",                   hl.dsp.window.move({ direction = "u" }))
bind("Move window", mainMod .. " + SHIFT + Right",                hl.dsp.window.move({ direction = "r" }))
bind("Move window", mainMod .. " + SHIFT + Left",                 hl.dsp.window.move({ direction = "l" }))
bind("Move window", mainMod .. " + SHIFT + Down",                 hl.dsp.window.move({ direction = "d" }))
for i = 1, NUM_WPM do
    local key = i % 10
    bind("Move window", mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
bind("Move window", mainMod .. " + SHIFT + mouse_up",             hl.dsp.window.move({ monitor   = "-1" }))
bind("Move window", mainMod .. " + SHIFT + mouse_down",           hl.dsp.window.move({ monitor   = "+1" }))
bind("Move window", mainMod .. " + CONTROL + SHIFT + Right",      hl.dsp.window.move({ workspace = "m+1" }))
bind("Move window", mainMod .. " + CONTROL + SHIFT + Left",       hl.dsp.window.move({ workspace = "m-1" }))
bind("Move window", mainMod .. " + CONTROL + SHIFT + mouse_up",   hl.dsp.window.move({ workspace = "m-1" }))
bind("Move window", mainMod .. " + CONTROL + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "m+1" }))
for i = 1, NUM_WPM do
    local key = i % 10
    bind("Move window", mainMod .. " + SHIFT + CONTROL + " .. key, hl.dsp.window.move({ workspace = "m~" .. i }))
end

-- Move & Resize with mouse
bind("Drag window", mainMod .. " + mouse:272", hl.dsp.window.drag())
bind("Resize window", mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Zoom
local function zoomfunction(value)
    local zoomvalue = hl.get_config("cursor:zoom_factor")
    if (zoomvalue + value) > 3.0 then
        hl.config({ cursor = { zoom_factor = 3.0 } })
    elseif (zoomvalue + value) < 1.0 then
        hl.config({ cursor = { zoom_factor = 1.0 } })
    else
        hl.config({ cursor = { zoom_factor = zoomvalue + value } })
    end
end
bind("Adjust cursor zoom", mainMod .. " + Minus", function() zoomfunction(-0.3) end, { repeating = true})
bind("Adjust cursor zoom", mainMod .. " + Plus", function() zoomfunction(0.3) end, { repeating = true })

--# Zoom with keypad
bind("Adjust cursor zoom", mainMod .. " + KP_Subtract", function() zoomfunction(-0.3) end, { repeating = true })
bind("Adjust cursor zoom", mainMod .. " + KP_Add", function() zoomfunction(0.3) end, { repeating = true })


------------------
---- LAUNCHER ----
------------------

bind("New terminal", mainMod .. " + Return",     hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.unbind("SUPER + E")
bind("Launch or focus files", "SUPER + E", hl.dsp.exec_cmd("/usr/bin/python " .. home .. "/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py app files"))
hl.unbind("SUPER + ALT + T")
bind("Launch or focus editor", "SUPER + ALT + T", hl.dsp.exec_cmd("/usr/bin/python " .. home .. "/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py app editor"))
hl.unbind("SUPER + CONTROL + C")
bind("Launch or focus calculator", "SUPER + CONTROL + C", hl.dsp.exec_cmd("/usr/bin/python " .. home .. "/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py app calculator"))
bind("Open calculator", "XF86Calculator",           hl.dsp.exec_cmd(launchPrefix .. CALCULATOR))
hl.unbind("SUPER + ALT + W")
bind("Launch or focus browser", "SUPER + ALT + W", hl.dsp.exec_cmd("/usr/bin/python " .. home .. "/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py app browser"))
bind("Open system monitor", "CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e btop"))
bind("Toggle desktop settings", mainMod .. " + ALT + Z",          hl.dsp.exec_cmd(noctCall .. "settings-toggle"))
bind("Toggle control center", mainMod .. " + ALT + X",          hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center"))
bind("Application launcher", mainMod .. " + Space",      hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))
bind("Application launcher", mainMod .. " + period",     hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher /emo"))
bind("Lock session", mainMod .. " + L",          hl.dsp.exec_cmd(noctCall .. "session lock"))
bind("Session menu", mainMod .. " + ALT + C",    hl.dsp.exec_cmd(noctCall .. "panel-toggle session"))

---------------------------
---- HARDWARE CONTROLS ----
---------------------------

-- Audio
bind("Raise volume", "XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume-up"),   { locked = true, repeating = true })
bind("Lower volume", "XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume-down"), { locked = true, repeating = true })
bind("Mute output", "XF86AudioMute",        hl.dsp.exec_cmd(noctCall .. "volume-mute"), { locked = true })
bind("Mute microphone", "XF86AudioMicMute",     hl.dsp.exec_cmd(noctCall .. "mic-mute"),    { locked = true })

-- Media
bind("Media", "XF86AudioPlay",  hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true })
bind("Media", "XF86AudioPause", hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true })
bind("Media", "XF86AudioNext",  hl.dsp.exec_cmd(noctCall .. "media next"),     { locked = true })
bind("Media", "XF86AudioPrev",  hl.dsp.exec_cmd(noctCall .. "media previous"), { locked = true })

-- Brightness
bind("Brightness", "XF86MonBrightnessUp",   hl.dsp.exec_cmd(noctCall .. "brightness-up"),   { locked = true, repeating = true })
bind("Brightness", "XF86MonBrightnessDown", hl.dsp.exec_cmd(noctCall .. "brightness-down"), { locked = true, repeating = true })

-------------------
---- UTILITIES ----
-------------------


-- Screen Capture
bind("Pick screen color", mainMod .. " + ALT + P",     hl.dsp.exec_cmd("hyprpicker -a -n"))
bind("Capture region", "Print",               hl.dsp.exec_cmd(noctCall .. "screenshot-region"))
bind("Capture monitor", mainMod .. " + Print", hl.dsp.exec_cmd(noctCall .. "screenshot-fullscreen"))

-- Theming and Wallpaper
bind("Theming and Wallpaper", mainMod .. " + ALT + SHIFT + W", hl.dsp.exec_cmd(noctCall .. "panel-toggle wallpaper"))

-- Clipboard

-- Notifications
bind("Notifications", mainMod .. " + ALT + A", hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center notifications"))

-------------------------------
---- WORKSPACES & MONITORS ----
-------------------------------

-- Focus on monitors
bind("Focus window / workspace", mainMod .. " + ALT + 1", hl.dsp.focus({ monitor = MONITOR1 }))
bind("Focus window / workspace", mainMod .. " + ALT + 2", hl.dsp.focus({ monitor = MONITOR2 }))
bind("Focus window / workspace", mainMod .. " + ALT + 3", hl.dsp.focus({ monitor = MONITOR3 }))

-- Focus on workspace number
-- Absolute
for i = 1, NUM_WPM do
    local key = i % 10
    bind("Focus window / workspace", mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end
-- Relative
for i = 1, NUM_WPM do
    local key = i % 10
    bind("Focus window / workspace", mainMod .. " + CONTROL + " .. key, hl.dsp.focus({ workspace = "m~" .. i }))
end

-- Move to adjacent workspaces and next empty on a given monitor
bind("Focus window / workspace", mainMod .. " + CONTROL + Right",       hl.dsp.focus({ workspace = "m+1" }))
bind("Focus window / workspace", mainMod .. " + CONTROL + Left",        hl.dsp.focus({ workspace = "m-1" }))
bind("Focus window / workspace", mainMod .. " + CONTROL + Down",        hl.dsp.focus({ workspace = "emptym" }))

-- Scroll through existing workspaces & monitors
bind("Focus window / workspace", mainMod .. " + mouse_down",           hl.dsp.focus({ workspace = "m+1" }))
bind("Focus window / workspace", mainMod .. " + mouse_up",             hl.dsp.focus({ workspace = "m-1" }))
bind("Focus window / workspace", mainMod .. " + CONTROL + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
bind("Focus window / workspace", mainMod .. " + CONTROL + mouse_up",   hl.dsp.focus({ workspace = "m-1" }))

-- Special workspace (scratchpad)
bind("Move window", mainMod .. " + ALT + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratch" }))
bind("Special workspace (scratchpad)", mainMod .. " + ALT + S",         hl.dsp.workspace.toggle_special("scratch"))

-- Delete selection / move files to trash with the Apple keyboard.
bind("Delete selection / move files to trash", mainMod .. " + BackSpace", hl.dsp.send_shortcut({ mods = "", key = "Delete" }))
bind("Application launcher", "ALT + Space", hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))
bind("Capture monitor", mainMod .. " + ALT + SHIFT + 3", hl.dsp.exec_cmd(noctCall .. "screenshot-fullscreen"))
bind("Capture region", mainMod .. " + SHIFT + 4", hl.dsp.exec_cmd(noctCall .. "screenshot-region"))

-- Personal workflow layer
hl.unbind("SUPER + ALT + M")
bind("Search desktop actions", "SUPER + ALT + M", hl.dsp.exec_cmd("/usr/bin/python " .. home .. "/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py menu"))
hl.unbind("SUPER + ALT + V")
bind("Clipboard history", "SUPER + ALT + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.unbind("SUPER + ALT + O")
bind("Extract region text locally", "SUPER + ALT + O", hl.dsp.exec_cmd("/usr/bin/python " .. home .. "/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py ocr"))
hl.unbind("SUPER + ALT + K")
bind("Search shortcut guide", "SUPER + ALT + K", hl.dsp.exec_cmd("/usr/bin/python " .. home .. "/hermes-workspace/projects/desktop/cachyos-workflows/desktop.py keys"))
return catalog
