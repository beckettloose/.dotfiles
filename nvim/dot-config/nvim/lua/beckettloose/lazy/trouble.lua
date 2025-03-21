return {
    {
        "folke/trouble.nvim",
        config = function()

            require("trouble").setup()

            vim.keymap.set("n", "<leader>vt", function()
                require("trouble").toggle("diagnostics")
            end, { desc = "[T]rouble" })

            vim.keymap.set("n", "[t", function()
                ---@diagnostic disable-next-line: missing-parameter, missing-fields
                require("trouble").prev({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                ---@diagnostic disable-next-line: missing-parameter, missing-fields
                require("trouble").next({skip_groups = true, jump = true});
            end)

        end
    }
}
