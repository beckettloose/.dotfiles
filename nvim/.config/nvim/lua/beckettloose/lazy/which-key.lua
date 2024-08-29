return { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        local wk = require("which-key")
        wk.setup()

        -- Document existing key chains
        wk.add({

            { "<leader>v", group = "[V]im" },
            { "<leader>v_", hidden = true },

            { "<leader>n", group = "Harpoo[n]" },
            { "<leader>n_", hidden = true },

            { "<leader>h", group = "Git [H]unk" },
            { "<leader>h_", hidden = true },

            { "<leader>d", group = "[D]iff View" },
            { "<leader>d_", hidden = true },

            { "[", group = "Previous" },
            { "[_", hidden = true },

            { "]", group = "Next" },
            { "]_", hidden = true },

            { "<leader>z", group = "[Z]en Mode" },
            { "<leader>z_", hidden = true },

            {
                -- visual mode
                mode = { "v" },
                { "<leader>h", desc = "Git [H]unk" },
            }
        })
    end,
}
