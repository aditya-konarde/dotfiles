-- Hyprland 0.56.2 can replace the restored workspace while removing FALLBACK.
-- Preserve the last active workspace across a single-display dock disconnect.
-- Do not interfere with normal multi-monitor placement or session locking.
local last_workspace, pending_workspace
local attempts = 0

local function physical_monitors()
    local result = {}
    for _, monitor in ipairs(hl.get_monitors()) do
        if monitor.name ~= "FALLBACK" then
            result[#result + 1] = monitor
        end
    end
    return result
end

local function remember()
    if pending_workspace or #physical_monitors() ~= 1 then return end
    local ws = hl.get_active_workspace()
    if ws and ws.id > 0 then last_workspace = ws.id end
end

local settle
settle = hl.timer(function()
    attempts = attempts + 1
    local monitors = hl.get_monitors()
    local physical = physical_monitors()
    if #physical == 1 and #monitors == 1 and pending_workspace then
        local target = pending_workspace
        -- Stop before dispatch: focusing emits workspace.active synchronously.
        pending_workspace = nil
        settle:set_enabled(false)
        if hl.get_workspace(target) then
            hl.dispatch(hl.dsp.focus({ workspace = target }))
            print("workspace-reconnect: restored workspace " .. target)
        end
        remember()
    elseif attempts >= 20 then
        pending_workspace = nil
        settle:set_enabled(false)
    end
end, { timeout = 500, type = "repeat" })
settle:set_enabled(false)

hl.on("workspace.active", remember)
hl.on("monitor.removed", function(monitor)
    local remaining = 0
    for _, other in ipairs(physical_monitors()) do
        if other.name ~= monitor.name then remaining = remaining + 1 end
    end
    if monitor.name ~= "FALLBACK" and remaining == 0 then
        pending_workspace = last_workspace
        settle:set_enabled(false)
    end
end)
hl.on("monitor.added", function(monitor)
    if monitor.name ~= "FALLBACK" and pending_workspace then
        attempts = 0
        settle:set_enabled(true)
    end
end)
remember()
