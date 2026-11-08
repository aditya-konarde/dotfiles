-- Ordinary numbered workspaces; preserve empty workspaces 1-3.
-- Reconnect focus is handled by workspace_reconnect.lua.
for id = 1, 3 do
    hl.workspace_rule({ workspace = tostring(id), default_name = tostring(id), persistent = true })
end
