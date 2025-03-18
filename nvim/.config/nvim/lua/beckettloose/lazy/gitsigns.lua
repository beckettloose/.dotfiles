return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            signs_staged_enable = true,
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'rounded',
                style = 'minimal',
                relative = 'cursor',
                row = 1,
                col = 0,
            },
            on_attach = function (bufnr)
                local gitsigns = require("gitsigns")

                local function map (mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']h', function ()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { desc = "Next [H]unk" })

                map('n', '[h', function ()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { desc = "Previous [H]unk" } )

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "[s]tage Hunk" })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "[r]eset Hunk" })
                map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "[S]tage Hunk" })
                map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "[R]eset Hunk" })
                map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "[S]tage Buffer" })
                map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "[R]eset Buffer" })
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[p]review Hunk" })
                map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "[b]lame Hunk" })
                map('n', '<leader>ht', gitsigns.toggle_current_line_blame, { desc = "[T]oggle Current Line Blame" })
                map('n', '<leader>hd', gitsigns.diffthis, { desc = "[d]iff This" })
                map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "[D]iff This Buffer" })
                map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "[i]nline Preview Hunk" })
            end
        })
    end
}
