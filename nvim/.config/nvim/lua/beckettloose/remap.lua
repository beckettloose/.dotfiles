-- remap.lua: Remap keys for neovim. Borrowed from kickstart.nvim and ThePrimeagen

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlight on <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- borrowed from ThePrimeagen
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "File [E]xplorer" })

--vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Vim-With-Me
-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- "greatest remap ever" - ThePrimeagen
-- vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("x", "<leader>p", [["0p]], { desc = "[p]aste from Yank Register" })

-- "next greatest remap ever" - ThePrimeagen
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank Selection to Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank Line to Clipboard" })

-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- "This is going to get me cancelled" - ThePrimeagen
-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- Unmap Q
vim.keymap.set("n", "Q", "<nop>")

-- Open tmux sessionizer
vim.keymap.set("n", "<C-f>", '<cmd>silent !tmux neww -n sessionizer "tmux-sessionizer 1"<CR>')

-- Format buffer
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Next and Prev LSP warnings
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Next and Prev location list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next Location List Item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev Location List Item" })

-- IDK???
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Mark current file as executable
vim.keymap.set("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "[M]ark File E[x]ecutable" })

-- IDK??
-- vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- TODO: Diagnostic Keymaps from old init

-- Disable arrow keys to break the habit of using them
vim.keymap.set("n", "<left>", '<cmd> echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd> echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd> echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd> echo "Use j to move!!"<CR>')
