local M = {}

---@alias LidState "open" | "close"
---@alias Config { laptop: string, scaleSolo: number, scaleDocked: number }

---@type Config | nil
local config

---@type LidState
local lidState = "open"

---@param opts Config
function M.setup(opts)
    config = opts

    M.applyScale()
    hl.on("monitor.added", M.applyScale)
    hl.on("monitor.removed", M.applyScale)
end

function M.hasExternal()
    if config == nil then
        return false
    end

    for _, monitor in ipairs(hl.get_monitors()) do
        if monitor.name ~= config.laptop then
            return true
        end
    end
    return false
end

function M.applyScale()
    if config == nil then
        return
    end

    if lidState == "close" then
        if M.hasExternal() then
            hl.monitor({ output = config.laptop, disabled = true })
        else
            os.execute("systemctl suspend")
        end
    else
        hl.monitor({
            output = config.laptop,
            disabled = false,
            mode = "preferred",
            position = "auto",
            scale = M.hasExternal() and config.scaleDocked or config.scaleSolo,
        })
    end
end

---@param state LidState
function M.handleLidEvent(state)
    if
        (state ~= "open" and state ~= "close")
        or state == lidState
        or config == nil
    then
        return
    end
    lidState = state

    M.applyScale()
end

return M
