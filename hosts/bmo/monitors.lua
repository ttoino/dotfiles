local LAPTOP_MONITOR = "eDP-2"
local LAPTOP_SCALE_SOLO = 1.3333
local LAPTOP_SCALE_DOCKED = 1

local function hasExternalMonitor()
    for _, monitor in ipairs(hl.get_monitors()) do
        if monitor.name ~= LAPTOP_MONITOR then
            return true
        end
    end
    return false
end

local function applyLaptopScale()
    hl.monitor({
        output = LAPTOP_MONITOR,
        mode = "preferred",
        position = "auto",
        scale = hasExternalMonitor() and LAPTOP_SCALE_DOCKED
            or LAPTOP_SCALE_SOLO,
    })
end

-- External monitors
hl.monitor({
    output = "desc:Samsung Electric Company LC32G5xT H4ZR703681",
    mode = "preferred",
    position = "auto-left",
    scale = 1,
    bitdepth = 10,
})

hl.monitor({
    output = "desc:LG Electronics LG ULTRAGEAR+ 502NTPC06960",
    mode = "preferred",
    position = "auto-left",
    scale = 1,
    bitdepth = 10,
})

-- Fallback for unknown monitors
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- Dynamic eDP-2 scale: solo = 1.3333, docked = 1
applyLaptopScale()
hl.on("monitor.added", applyLaptopScale)
hl.on("monitor.removed", applyLaptopScale)
