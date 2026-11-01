---@param name string
---@param stiffness number
---@param dampingRatio number
local function m3Spring(name, stiffness, dampingRatio)
    hl.curve(name, {
        type = "spring",
        mass = 1,
        stiffness = stiffness,
        damping = dampingRatio * 2 * math.sqrt(stiffness),
    })
end

m3Spring("m3-expressive-spatial-fast", 800, 0.6)
m3Spring("m3-expressive-spatial-default", 380, 0.8)
m3Spring("m3-expressive-spatial-slow", 200, 0.8)
m3Spring("m3-expressive-effects-slow", 800, 1.0)
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5.0,
    spring = "m3-expressive-spatial-default",
    style = "popin",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 3.5,
    spring = "m3-expressive-spatial-fast",
    style = "popin 80%",
})
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 5.0,
    spring = "m3-expressive-spatial-default",
    style = "slide",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.0,
    spring = "m3-expressive-effects-slow",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6.5,
    spring = "m3-expressive-spatial-slow",
    style = "slide",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 5.0,
    spring = "m3-expressive-spatial-default",
    style = "fade",
})
hl.animation({
    leaf = "monitorAdded",
    enabled = true,
    speed = 6.5,
    spring = "m3-expressive-spatial-slow",
})
