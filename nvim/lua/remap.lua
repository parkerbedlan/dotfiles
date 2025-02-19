vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
vim.keymap.set("n", "-", vim.cmd.Oil)

-- pog (bruh why didn't I do this sooner, this is as much of a game changer as the caps-esc swap and Oil.nvim
vim.keymap.set("n", "s", ":w<CR>")
-- temporary, to break the habit of using :w manually
-- vim.keymap.set("n", ":", "<nop>")
vim.keymap.set("n", "S", ":OrganizeImports<CR>:w<CR>")

-- Parker's custom keymaps
-- <C-BS> actually outputs <C-h> when using a terminal, so this lets you use <C-BS> like a normal person! No more accidentally closing the tab in your browser when you've mistyped a word!
vim.keymap.set("i", "<C-h>", "<C-w>")
-- also making <C-w> not do anything just to force myself to break the habit of using it to backspace lol
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

-- actual greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")

-- Nah, I commented this out because I use Esc instead of <C-c> because I'm better than Prime. (also it's where the caps button usually is)
-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- I don't have tmux set up yet ;_;
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- shortcut to format the file
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- quick fix navigation, apparently
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replaces word that you were on
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- makes current file executable (I never use this so I'm commenting it out for now)
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- double taps that I don't use the variations of
-- The only other one is ZQ, and I'll just do :q! if I want to do that
vim.keymap.set("n", "Z", "ZZ")
-- I don't do fancy window splitting adjustment stuff, I just jump between what pops up from quickfix and stuff (I'm a single monitor andy, harpoon ftw)
vim.keymap.set("n", "<C-w>", "<C-w><C-w>")
