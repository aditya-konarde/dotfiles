-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

-- Refresh cap for Minisforum -> USB-C switch -> CalDigit TS4 -> Odyssey G80SD.
-- 240 Hz caused repeated USB4 display-bandwidth allocation errors and blackouts.
-- Keep MONITOR1 empty so this cap survives connector-name changes on reconnect.
-- If this path becomes unstable at 120 Hz, 3840x2160@60 is the verified fallback.
hl.monitor({
    output    = MONITOR1,
    mode      = "3840x2160@120",
    position  = "auto",
    scale     = "auto",
    bitdepth  = 10,
    cm        = "hdr",
})
