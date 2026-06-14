hl.curve(
    "m3-expressive-spatial-fast",
    { type = "bezier", points = { { 0.42, 1.67 }, { 0.21, 0.90 } } }
)
hl.curve(
    "m3-expressive-spatial-default",
    { type = "bezier", points = { { 0.38, 1.21 }, { 0.22, 1.00 } } }
)
hl.curve(
    "m3-expressive-spatial-slow",
    { type = "bezier", points = { { 0.39, 1.29 }, { 0.35, 0.98 } } }
)
hl.curve(
    "m3-expressive-effects-slow",
    { type = "bezier", points = { { 0.34, 0.88 }, { 0.34, 1.00 } } }
)
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5.0,
    bezier = "m3-expressive-spatial-default",
    style = "popin",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 3.5,
    bezier = "m3-expressive-spatial-fast",
    style = "popin 80%",
})
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 5.0,
    bezier = "m3-expressive-spatial-default",
    style = "slide",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.0,
    bezier = "m3-expressive-effects-slow",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6.5,
    bezier = "m3-expressive-spatial-slow",
    style = "slide",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 5.0,
    bezier = "m3-expressive-spatial-default",
    style = "fade",
})
hl.animation({
    leaf = "monitorAdded",
    enabled = true,
    speed = 6.5,
    bezier = "m3-expressive-spatial-slow",
})
