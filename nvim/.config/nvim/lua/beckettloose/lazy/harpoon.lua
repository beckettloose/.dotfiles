return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon: [A]dd buffer" })

        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon: Op[e]n list" })


        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon: Buffer 1" })

        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon: Buffer 2" })

        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon: Buffer 3" })

        vim.keymap.set("n", "<C-s>", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon: Buffer 4" })

        vim.keymap.set("n", "<leader><C-h>", function()
            harpoon:list():replace_at(1)
        end, { desc = "Harpoon: Store Buffer 1" })

        vim.keymap.set("n", "<leader><C-t>", function()
            harpoon:list():replace_at(2)
        end, { desc = "Harpoon: Store Buffer 2" })

        vim.keymap.set("n", "<leader><C-n>", function()
            harpoon:list():replace_at(3)
        end, { desc = "Harpoon: Store Buffer 3" })

        vim.keymap.set("n", "<leader><C-s>", function()
            harpoon:list():replace_at(4)
        end, { desc = "Harpoon: Store Buffer 4" })
    end,
}
