-- Work around a black display after reconnecting the last monitor while locked.
-- Retry failed (0x0) modesets and wake it; authentication stays intact.
-- Optional bounded recovery helper; diagnostic captures stay local.
local recover = "hypr-lock-display-recover"
hl.bind("SUPER + CONTROL + SHIFT + R", hl.dsp.exec_cmd(recover .. " --manual"), { locked = true })
hl.on("monitor.added", function(monitor)
    if monitor.name ~= "FALLBACK" then
        hl.exec_cmd(recover .. " --hotplug")
    end
end)
