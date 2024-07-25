return { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        local wk = require("which-key")
        wk.setup()

        -- Document existing key chains
        wk.add({
            { "<leader>c", group = "[C]ode" },
            { "<leader>c_", hidden = true },

            { "<leader>d", group = "[D]ocument" },
            { "<leader>d_", hidden = true },

            { "<leader>r", group = "[R]ename" },
            { "<leader>r_>", hidden = true },

            { "<leader>s", group = "[S]earch" },
            { "<leader>s_", hidden = true },

            { "<leader>w", group = "[W]orkspace" },
            { "<leader>w_", hidden = true },

            { "<leader>t", group = "[T]oggle" },
            { "<leader>t_", hidden = true },

            { "<leader>m", group = "[M]ark File" },
            { "<leader>m_", hidden = true },

            { "<leader>n", group = "Harpoo[n]" },
            { "<leader>n_", hidden = true },

            { "<leader>h", group = "Git [H]unk" },
            { "<leader>h_", hidden = true },

            { "<leader><C-d>", group = "[D]iff View" },
            { "<leader><C-d>_", hidden = true },

            { "[", group = "Previous" },
            { "[_", hidden = true },

            { "]", group = "Next" },
            { "]_", hidden = true },

            {
                -- visual mode
                mode = { "v" },
                { "<leader>h", desc = "Git [H]unk" },
            }
        })
    end,
}
