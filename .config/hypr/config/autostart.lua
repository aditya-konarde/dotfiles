-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    -- Enable DND once Noctalia is ready, without blocking other startup apps.
    hl.exec_cmd([[sh -c 'for attempt in $(seq 1 30); do noctalia msg notification-dnd-set on >/dev/null 2>&1 && exit 0; sleep 1; done; echo "Noctalia: could not enable startup DND" >&2; exit 1']])
    -- Keep Handy resident so the global shortcut only has to toggle transcription.
    hl.exec_cmd("handy --start-hidden")
    hl.exec_cmd("xhost +SI:localuser:root")
    -- launch browser and terminal at startup
    hl.exec_cmd("uwsm app -- " .. TERMINAL)
    hl.exec_cmd("uwsm app -- " .. BROWSER)
end)
