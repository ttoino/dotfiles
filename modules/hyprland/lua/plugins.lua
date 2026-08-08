hl.on("config.reloaded", function()
    if hl.plugin.shadows_plus_plus ~= nil then
        hl.config({
            plugin = {
                shadows_plus_plus = {
                    add_shadows = 2,

                    shadow_1 = {
                        offset = { 0, 4 },
                        blur_radius = 4,
                        spread_radius = 0,
                        color = "rgba(0,0,0,0.30)",
                    },

                    shadow_2 = {
                        offset = { 0, 8 },
                        blur_radius = 12,
                        spread_radius = 6,
                        color = "rgba(0,0,0,0.15)",
                    },
                },
            },
        })
    end
end)
