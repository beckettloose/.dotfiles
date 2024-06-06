return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "[A]dd buffer" })

        vim.keymap.set("n", "<leader>he", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Op[e]n list" })


        vim.keymap.set("n", "<leader>h1", function()
            harpoon:list():select(1)
        end, { desc = "Buffer [1]" })

        vim.keymap.set("n", "<leader>h2", function()
            harpoon:list():select(2)
        end, { desc = "Buffer [2]" })

        vim.keymap.set("n", "<leader>h3", function()
            harpoon:list():select(3)
        end, { desc = "Buffer [3]" })

        vim.keymap.set("n", "<leader>h4", function()
            harpoon:list():select(4)
        end, { desc = "Buffer [4]" })

        vim.keymap.set("n", "<leader>h<S-1>", function()
            harpoon:list():replace_at(1)
        end, { desc = "Store Buffer [1]" })

        vim.keymap.set("n", "<leader>h<S-2>", function()
            harpoon:list():replace_at(2)
        end, { desc = "Store Buffer [2]" })

        vim.keymap.set("n", "<leader>h<S-3>", function()
            harpoon:list():replace_at(3)
        end, { desc = "Store Buffer [3]" })

        vim.keymap.set("n", "<leader>h<S-4>", function()
            harpoon:list():replace_at(4)
        end, { desc = "Store Buffer [4]" })
    end,
}
