return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            "nvim-telescope/telescope-fzf-native.nvim",

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = "make",

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
        -- Telescope is a fuzzy finder that comes with a lot of different things that
        -- it can fuzzy find! It's more than just a "file finder", it can search
        -- many different aspects of Neovim, your workspace, LSP, and more!
        --
        -- The easiest way to use Telescope, is to start by doing something like:
        --  :Telescope help_tags
        --
        -- After running this command, a window will open up and you're able to
        -- type in the prompt window. You'll see a list of `help_tags` options and
        -- a corresponding preview of the help.
        --
        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        --
        -- This opens a window that shows you all of the keymaps for the current
        -- Telescope picker. This is really useful to discover what Telescope can
        -- do as well as how to actually do it!

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require("telescope").setup({
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            -- defaults = {
            --   mappings = {
            --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --   },
            -- },
            -- pickers = {}
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
                file_browser = {
                    hidden = { file_browser = true, folder_browser = true },
                },
            },
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find [F]iles" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find Git Files" })
        -- vim.keymap.set("n", "<leader>pws", function()
        --     local word = vim.fn.expand("<cword>")
        --     builtin.grep_string({ search = word })
        -- end)
        -- vim.keymap.set("n", "<leader>pWs", function()
        --     local word = vim.fn.expand("<cWORD>")
        --     builtin.grep_string({ search = word })
        -- end)
        -- vim.keymap.set("n", "<leader>ps", function()
        --     builtin.grep_string({ search = vim.fn.input("Grep > ") })
        -- end)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "[H]elp Search" })

        vim.keymap.set("n", "<leader>vk", builtin.keymaps, { desc = "[K]eybind Search" })

        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

        vim.keymap.set("n", "<leader>x", ":Telescope file_browser<CR>", { desc = "Telescope File E[x]plorer" })

        vim.keymap.set("n", "<leader>vcl", builtin.filetypes, { desc = "[L]anguage" })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzy Search in Current Buffer" })

    end,
}
