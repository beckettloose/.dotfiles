-- cmp.lua: Autocomplete through hrsh7th/nvim-cmp.

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                -- Build step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets
                -- See the README about individual language/framework/plugin snippets:
                -- https://github.com/rafamadriz/friendly-snippets
                -- {
                --    'rafamadriz/friendly-snippets',
                --    config = function()
                --      require('luasnip.loaders.from_vscode').lazy_load()
                --    end,
                -- },
            },
        },
        "saadparwaiz1/cmp_luasnip",

        -- Adds other completion capabilities
        -- nvim-cmp does not ship with all sources by default. They are split
        -- into multiple repos for maintinence purposes
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
        -- See `:help cmp`
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },

            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ["<C-n>"] = cmp.mapping.select_next_item(),

                -- Select the [p]revious item
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion
                -- This will auto-import if your LSP supports it.
                -- This will expand snippets if the LSP sent a snippet.
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                -- Also accept the completion with tab
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),

                -- If you prefer more traditional completion keymaps,
                -- you can uncomment the following lines
                -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
                -- ["<Tab>"] = cmp.mapping.select_next_item(),
                -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),

                -- Manually trigger a completion from nvim-cmp.
                -- Generally you don't need this, because nvim-cmp will display
                -- completions whenever it has completion options available
                -- ["<C-Space>"] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snipped expansion.
                -- So if you have a snippet that's like:
                --  function $name($args)
                --      $body
                --  end
                --
                --  <c-l> will move you to the right of each of the expansion locations.
                --  <c-h> is similar, except moving you backwards.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            }),
            sources = {
                {
                    name = "nvim_lsp",
                    ---@diagnostic disable-next-line: unused-local
                    entry_filter = function (entry, ctx)
                        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                    end
                },
                { name = "luasnip" },
                { name = "path" },
                { name = "nvim_lsp_signature_help" },
            },
        })
    end,
}
