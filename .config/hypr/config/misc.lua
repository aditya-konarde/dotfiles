hl.config({
    -- Avoid the v0.56.2 Dwindle resizeTarget crash (2026-10-24).
    general = { layout = "master" },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
    misc = {
        -- Allow a supervised locker to reclaim an abandoned lock after a crash.
        allow_session_lock_restore = true,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        key_press_enables_dpms = true,
        mouse_move_enables_dpms = true,
        middle_click_paste = false,
        -- Keep terminal-launched apps separate instead of replacing the terminal.
        enable_swallow = false,
        -- Fixed refresh avoids OLED brightness flicker in dark content.
        vrr = 0,
    },
    render = {
        -- Avoid repeated 8/10-bit output modesets with Wine launchers on HDR desktop.
        direct_scanout = 0,
    },
    xwayland = {
        force_zero_scaling = true
    },
})
