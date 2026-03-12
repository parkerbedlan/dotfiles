local _99 = require("99")

local ClaudeCodeProvider = _99.Providers.ClaudeCodeProvider
local WrappedClaudeProvider = setmetatable({}, { __index = ClaudeCodeProvider })

function WrappedClaudeProvider._build_command(_, query, context)
    local cmd = string.format(
        "cd %s && claude --dangerously-skip-permissions --model %s --print %s",
        vim.fn.shellescape(vim.fn.getcwd()),
        vim.fn.shellescape(context.model),
        vim.fn.shellescape(query)
    )
    return { "su", "-", "dev", "-c", cmd }
end

_99.setup({
    completion = { source = "native" },
    provider = WrappedClaudeProvider,
    model = "claude-sonnet-4-6",
    tmp_dir = "/tmp/99-nvim",
})

vim.keymap.set("n", "<leader>9s", _99.search, { desc = "99: AI search" })
vim.keymap.set("v", "<leader>9v", _99.visual, { desc = "99: AI visual" })
vim.keymap.set("n", "<leader>9x", _99.stop_all_requests, { desc = "99: stop all requests" })
