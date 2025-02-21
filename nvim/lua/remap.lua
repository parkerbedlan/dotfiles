vim.g.mapleader = " "

vim.keymap.set("n", "s", ":w<CR>")
-- temporary, to break the habit of using :w manually
-- vim.keymap.set("n", ":", "<nop>")
vim.keymap.set("n", "S", ":OrganizeImports<CR>:w<CR>")

-- <C-BS> actually outputs <C-h> when using a terminal, so this lets you use <C-BS> like a normal person! No more accidentally closing the tab in your browser when you've mistyped a word!
vim.keymap.set("i", "<C-h>", "<C-w>")
vim.keymap.set("i", "<C-w>", "<nop>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- (I don't use this much because I mostly rely on the system clipboard but it's an interesting idea)
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")

vim.keymap.set("n", "Q", "<nop>")
-- I don't have tmux set up to do this yet ;_;
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- quick fix navigation, apparently (I don't think it ever worked for me)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replaces word that you were on
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- double taps that I don't use the variations of
-- The only other one is ZQ, and I'll just do :q! if I want to do that
vim.keymap.set("n", "Z", "ZZ")
-- I don't do fancy window splitting adjustment stuff, I just jump between what pops up from quickfix and stuff (I'm a single monitor andy, harpoon ftw)
-- for some reason it's not working so I'm using tab for now, which also isn't quite working but it's working better so it'll do for now
-- vim.keymap.set("n", "<C-w>", "<C-w><C-w>", {noremap = true, silent = true})
vim.keymap.set("n", "<C-w>", "<C-w><C-w>", { nowait = true })
