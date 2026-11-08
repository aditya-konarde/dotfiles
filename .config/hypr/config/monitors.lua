-- Refresh cap for Minisforum -> USB-C switch -> CalDigit TS4 -> Odyssey G80SD.
-- 240 Hz caused repeated USB4 display-bandwidth allocation errors and blackouts.
-- Keep output empty so this cap survives connector-name changes on reconnect.
-- If this path becomes unstable at 120 Hz, 3840x2160@60 is the verified fallback.
hl.monitor({
    output    = "",
    mode      = "3840x2160@120",
    position  = "auto",
    scale     = "auto",
    bitdepth  = 10,
    cm        = "hdr",
})
