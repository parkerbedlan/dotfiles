vim.opt.nu = true
vim.opt.rnu = true

vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true


-- -- Define function for setting JavaScript and TypeScript indentation
-- function SetJsTsIndent()
--     if vim.bo.filetype == 'javascript' or vim.bo.filetype == 'typescript' then
--         vim.bo.tabstop = 2
--         vim.bo.softtabstop = 2
--         vim.bo.shiftwidth = 2
--         vim.bo.expandtab = true
--     end
-- end

-- -- Define autocmd for FileType
-- vim.api.nvim_exec([[
--   augroup SetJsTsIndent
--     autocmd!
--     autocmd FileType javascript,typescript lua SetJsTsIndent()
--   augroup END
-- ]], false)


vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hls = false
vim.opt.is = true
vim.opt.ic = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- https://github.com/monkoose/matchparen.nvim
vim.g.loaded_matchparen = 1
