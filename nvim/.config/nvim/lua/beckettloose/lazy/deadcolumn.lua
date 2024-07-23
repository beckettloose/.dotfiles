return {
    "Bekaboo/deadcolumn.nvim",
    opts = {
        scope = 'line',
        -- modes...
        blending = {
            threshold = 0.75,
            alpha = 0.4,
            colorcode = '#454545',
            -- hlgroup = { 'Normal', 'bg' },
        },
        warning = {
            alpha = 0.4,
            offset = 0,
            colorcode = '#FF0000',
            hlgroup = { 'Error', 'bg' },
        },
    },
}
