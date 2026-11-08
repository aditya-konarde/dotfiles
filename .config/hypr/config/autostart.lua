-- Hyprland owns this session; applications run as systemd user services.
hl.on("hyprland.start", function ()
    -- Export only desktop routing variables, then start the authentication agent.
    hl.exec_cmd("sh -c 'dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE UWSM_APP_UNIT_TYPE && systemctl --user restart hyprpolkitagent.service'")
    hl.exec_cmd("sh -c 'systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_SESSION_ID XDG_SESSION_TYPE XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE && systemctl --user restart noctalia-session.service'")
end)
