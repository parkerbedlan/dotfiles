local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
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
    vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)

    -- format on save via lsp-zero helper
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
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

-- --- Simple servers: enable the builtin configs from nvim-lspconfig/runtime
local simple_servers = {
    'rust_analyzer',
    'svelte',
    'nixd',
    'htmx',
    'dockerls',
    'marksman',
    'lemminx',
    'phpactor',
    'jsonls',
    'eslint',
}

for _, name in ipairs(simple_servers) do
    -- enable will activate the server using the config that nvim-lspconfig provides on the runtimepath
    pcall(vim.lsp.enable, name)
end

-- --- lua_ls: custom config + enable
vim.lsp.config('lua_ls', {
    -- on_init as you had it
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, {
            Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                    checkThirdParty = false,
                    library = { vim.env.VIMRUNTIME },
                },
            },
        })
    end,

    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})
pcall(vim.lsp.enable, 'lua_ls')

-- --- prettierd/efm config (document formatting)
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
        'package.json',
    },
}

vim.lsp.config('efm', {
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "css" },
    settings = {
        rootMarkers = { '.git/', 'package.json' },
        languages = {
            javascript = { prettierd },
            typescript = { prettierd },
            javascriptreact = { prettierd },
            typescriptreact = { prettierd },
            svelte = { prettierd },
            css = { prettierd },
        }
    }
})
pcall(vim.lsp.enable, 'efm')

-- --- typescript server (ts_ls) with disable-formatting & OrganizeImports command
local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

vim.lsp.config('ts_ls', {
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    on_attach = function(client, bufnr)
        -- disable ts_ls as a formatter (your previous logic)
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
pcall(vim.lsp.enable, 'ts_ls')

-- --- tailwindcss with experimental settings
vim.lsp.config('tailwindcss', {
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
})
pcall(vim.lsp.enable, 'tailwindcss')

-- --- format mapping & server config via lsp-zero
lsp_zero.format_mapping('gq', {
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['efm'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'css' },
        ['rust_analyzer'] = { 'rust' },
        ['lua_ls'] = { 'lua' },
        ['nixd'] = { 'nix' }
    },
})

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
