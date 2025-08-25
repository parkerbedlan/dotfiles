-- vim.cmd('silent! lua require("leap").set_default_mappings()')

require("flash").setup({
    jump = {
        autojump = true,
    },
})
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "<leader>s", function() require("flash").treesitter() end,
    { desc = "Flash Treesitter" })
