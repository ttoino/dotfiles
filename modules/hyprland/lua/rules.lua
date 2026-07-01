-- Games
hl.window_rule({ match = { class = "steam_app_.*" }, tag = "+game" })
hl.window_rule({ match = { class = "[Mm]inecraft" }, tag = "+game" })
hl.window_rule({ match = { tag = "game" }, immediate = true })

-- PiP
hl.window_rule({ match = { title = "discord\\.com/popout" }, tag = "+pip" })
hl.window_rule({ match = { title = "Picture-in-Picture" }, tag = "+pip" })
hl.window_rule({
    match = { tag = "pip" },
    float = true,
    keep_aspect_ratio = true,
    no_initial_focus = true,
    pin = true,
    opacity = "1",
    no_blur = true,
    no_dim = true,
    opaque = true,
})

local MARGIN = 16
local FRACTION = 0.25
local ASPECT_RATIO = 16 / 9

---@param monitor HL.Monitor
local function scaleOf(monitor)
    local scale = monitor.scale or 1
    if scale <= 0 then
        scale = 1
    end
    return scale
end

---@param monitor HL.Monitor
---@return number width
---@return number height
local function pipLayout(monitor)
    local scale = scaleOf(monitor)
    local logW, logH = monitor.width / scale, monitor.height / scale
    local maxWidth, maxHeight = logW * FRACTION, logH * FRACTION
    if maxWidth / maxHeight > ASPECT_RATIO then
        return maxHeight * ASPECT_RATIO, maxHeight
    end
    return maxWidth, maxWidth / ASPECT_RATIO
end

---@param window HL.Window|nil
local function isPip(window)
    if not window or not window.tags then
        return false
    end
    local tags = window.tags
    ---@cast tags string[]
    for _, tag in ipairs(tags) do
        if tag == "pip" or tag == "pip*" then
            return true
        end
    end
    return false
end

---@param window HL.Window
local function applyPipLayout(window)
    local monitor = window.monitor
    if not monitor then
        return
    end
    local width, height = pipLayout(monitor)
    local scale = scaleOf(monitor)
    local logW, logH = monitor.width / scale, monitor.height / scale
    local x = monitor.x + logW - width - MARGIN
    local y = monitor.y + logH - height - MARGIN
    hl.dispatch(
        hl.dsp.window.resize({ x = width, y = height, window = window })
    )
    hl.dispatch(
        hl.dsp.window.move({ x = x, y = y, relative = false, window = window })
    )
end

hl.on("window.update_rules", function(window)
    ---@cast window HL.Window
    if isPip(window) then
        applyPipLayout(window)
    end
end)

-- Shimeji
hl.window_rule({ match = { title = "oneko" }, tag = "+shimeji" })
hl.window_rule({
    match = { tag = "shimeji" },
    border_size = 0,
    float = true,
    no_blur = true,
    no_focus = true,
    no_shadow = true,
})
