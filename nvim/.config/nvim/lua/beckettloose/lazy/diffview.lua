return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        local diffview = require("diffview")
        -- local actions = require("diffview.actions")

        -- Keymaps to open and close diff view
        vim.keymap.set('n', "<leader><C-d>o", diffview.open, { desc = "[O]pen Diffview" })
        vim.keymap.set('n', "<leader><C-d>c", diffview.close, { desc = "[C]lose Diffview" })
        vim.keymap.set('n', "<leader><C-d>h", diffview.file_history, { desc = "File [H]istory" })

        diffview.setup({
            view = {
                default = {
                    layout = "diff2_horizontal",
                },
                merge_tool = {
                    layout = "diff3_mixed",
                },
                file_history = {
                    layout = "diff2_horizontal",
                }
            }
        })
    end
}
