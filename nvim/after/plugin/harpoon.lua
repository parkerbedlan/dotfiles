local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- using <C-\> instead of <C-e> for harpoon because I want to be able to use <C-e> and <C-y> for scroll wheel behavior without reaching for my mouse.
vim.keymap.set("n", "<C-\\>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(5) end)

vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():replace_at(2) end)
vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():replace_at(3) end)
vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():replace_at(4) end)
vim.keymap.set("n", "<leader><C-n>", function() harpoon:list():replace_at(5) end)
