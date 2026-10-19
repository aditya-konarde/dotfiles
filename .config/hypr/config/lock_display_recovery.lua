-- Work around a black display after reconnecting the last monitor while locked.
-- Retry failed (0x0) modesets and wake it; authentication stays intact.
-- Aquamarine 0.15.1 fixes the disconnected-output KMS leak. Retain read-only
-- evidence for one hour after login while validating the physical reconnect.
local home = os.getenv("HOME")
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/bin/python3 " .. home .. "/.local/state/hypr-lock-display/diagnostics/capture.py")
end)
local recover = home .. "/.local/bin/hypr-lock-display-recover"
hl.bind("SUPER + CONTROL + SHIFT + R", hl.dsp.exec_cmd(recover .. " --manual"), { locked = true })
hl.on("monitor.added", function(monitor)
    if monitor.name ~= "FALLBACK" then
        hl.exec_cmd(recover .. " --hotplug")
    end
end)
