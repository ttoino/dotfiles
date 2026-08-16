local M = {}

---@alias LidState "open" | "close"
---@alias PowerProfile "power-saver" | "balanced" | "performance"
---@alias Config { laptop: string, modeNormal: string, modePowerSaver: string, scaleSolo: number, scaleDocked: number }

---@type Config | nil
local config

---@type LidState
local lidState = "open"

---@type PowerProfile
local powerProfile = "balanced"

---@return PowerProfile
local function getPowerProfile()
    local handle = io.popen("powerprofilesctl get 2>/dev/null")
    if not handle then
        return "balanced"
    end
    local result = handle:read("*a"):gsub("%s+", "")
    handle:close()
    if
        result == "power-saver"
        or result == "balanced"
        or result == "performance"
    then
        return result
    end
    return "balanced"
end

---@return LidState
local function getLidState()
    local handle = io.popen("cat /proc/acpi/button/lid/*/state 2>/dev/null")
    if not handle then
        return "open"
    end
    local result = handle:read("*a"):lower()
    handle:close()
    if result:match("closed") then
        return "close"
    end
    return "open"
end

---@param opts Config
function M.setup(opts)
    config = opts

    powerProfile = getPowerProfile()
    lidState = getLidState()

    M.apply()
    hl.on("monitor.added", M.apply)
    hl.on("monitor.removed", M.apply)
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

function M.apply()
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
            mode = powerProfile == "power-saver" and config.modePowerSaver
                or config.modeNormal,
            position = "auto",
            scale = M.hasExternal() and config.scaleDocked or config.scaleSolo,
        })
    end
end

---@param profile PowerProfile
function M.handleProfileChange(profile)
    powerProfile = profile

    M.apply()
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

    M.apply()
end

return M
