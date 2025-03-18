return {
    "andrewferrier/wrapping.nvim",
    config = function ()
        local opts = {
            create_commands = true,
            create_keymaps = false
        }
        require("wrapping").setup(opts)

        vim.keymap.set("n", "<leader>vwh", function ()
            require('wrapping').hard_wrap_mode()
        end, { desc = "[H]ard" })

        vim.keymap.set("n", "<leader>vws", function ()
            require('wrapping').soft_wrap_mode()
        end, { desc = "[S]oft" })

        vim.keymap.set("n", "<leader>vwt", function ()
            require('wrapping').toggle_wrap_mode()
        end, { desc = "[T]oggle" })
    end
}
