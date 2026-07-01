require("05-monitors").setup({
    laptop = "eDP-2",
    scaleSolo = 1.3333,
    scaleDocked = 1,
})

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
