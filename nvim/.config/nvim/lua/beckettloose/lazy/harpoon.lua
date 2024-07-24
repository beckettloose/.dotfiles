return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>na", function()
            harpoon:list():add()
        end, { desc = "[A]dd buffer to Harpoon List" })

        vim.keymap.set("n", "<leader>ns", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "[S]how Harpoon List" })


        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
        end, { desc = "Select Harpoon Item 1" })

        vim.keymap.set("n", "<C-j>", function()
            harpoon:list():select(2)
        end, { desc = "Select Harpoon Item 2" })

        vim.keymap.set("n", "<C-k>", function()
            harpoon:list():select(3)
        end, { desc = "Select Harpoon Item 3" })

        vim.keymap.set("n", "<C-l>", function()
            harpoon:list():select(4)
        end, { desc = "Select Harpoon Item 4" })

        vim.keymap.set("n", "<leader><C-h>", function()
            harpoon:list():replace_at(1)
        end, { desc = "Replace Harpoon Item 1" })

        vim.keymap.set("n", "<leader><C-j>", function()
            harpoon:list():replace_at(2)
        end, { desc = "Replace Harpoon Item 2" })

        vim.keymap.set("n", "<leader><C-k>", function()
            harpoon:list():replace_at(3)
        end, { desc = "Replace Harpoon Item 3" })

        vim.keymap.set("n", "<leader><C-l>", function()
            harpoon:list():replace_at(4)
        end, { desc = "Replace Harpoon Item 4" })

        vim.keymap.set("n", "<leader>nc", function()
            harpoon:list():clear()
        end, { desc = "[C]lear Harpoon List" })
    end,
}
