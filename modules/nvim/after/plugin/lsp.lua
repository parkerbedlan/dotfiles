local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp_zero.on_attach(function(_client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- originally this was for insert mode <C-h>, which was the reason I couldn't do <C-h> or <C-BS> to delete the previous word in insert mode
    vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)

    -- format on save https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/lsp.md#always-use-the-active-servers
    -- instead atm I'm explicitly setting with format_on_save at the bottom of the file (this is because I sometimes use these editor settings at work, and formatting on save messes up the version control of legacy codebases unless you can get everyone on board with using a code formatter that formats on save.
    lsp_zero.buffer_autoformat()
end)

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip',                keyword_length = 2 },
        { name = 'nvim_lsp_signature_help' },
        -- could potentially comment out the below sources
        -- { name = 'buffer',                 keyword_length = 5 },
        -- { name = 'cmdline' },
        -- { name = 'cmdline_history' },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.txt
lspconfig.rust_analyzer.setup {}
lspconfig.svelte.setup {}
lspconfig.nixd.setup {}
lspconfig.htmx.setup {}
lspconfig.dockerls.setup {}
lspconfig.marksman.setup {}
lspconfig.lemminx.setup {}
lspconfig.phpactor.setup {}
lspconfig.jsonls.setup {}

lspconfig.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                -- globals = { "vim" },
            },
        }
    }
}

-- https://github.com/VonHeikemen/lsp-zero.nvim/issues/337#issuecomment-1783798483
local prettierd = {
    formatCommand = "prettierd '${INPUT}' ${--range-start=charStart} ${--range-end=charEnd}",
    formatCanRange = true,
    formatStdin = true,
    rootMarkers = {
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.js',
        '.prettierrc.yml',
        '.prettierrc.yaml',
        '.prettierrc.json5',
        '.prettierrc.mjs',
        '.prettierrc.cjs',
        '.prettierrc.toml',
        'prettier.config.js',
    },
}

lspconfig.efm.setup({
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
    settings = {
        rootMarkers = { '.git/' },
        languages = {
            javascript = { prettierd },
            typescript = { prettierd },
            javascriptreact = { prettierd },
            typescriptreact = { prettierd },
            svelte = { prettierd },
            css = { prettierd }
        }
    }
})

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup({
    on_attach = function(client)
        -- disable ts_ls as a formatter
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
})

lspconfig.tailwindcss.setup {
    filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ", "rust" },
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    "class=\"(.*)\""
                }
            }
        }
    }
}

lsp_zero.format_mapping('gq', {
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['efm'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'css' },
        ['ts_ls'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte' },
        ['rust_analyzer'] = { 'rust' },
        ['lua_ls'] = { 'lua' },
        ['nixd'] = { 'nix' }
    },
})

-- lsp_zero.format_on_save({
--     format_opts = {
--         async = false,
--         timeout_ms = 10000,
--     },
--     servers = {
--         ['efm'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'css' },
--         ['rust_analyzer'] = { 'rust' },
--         ['lua_ls'] = { 'lua' },
--         ['nixd'] = { 'nix' }
--     }
-- })


lsp_zero.set_server_config({
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
        }
    }
})
