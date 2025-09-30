local telescope = require('telescope')
telescope.setup {
    defaults = {
        layout_strategy = "vertical",
        -- layout_config = { height=0.95 }
    },
    pickers = {
        find_files = {
            hidden = true,
            disable_devicons = true,
        },
        git_files = {
            disable_devicons = true,
        },
        grep_string = {
            disable_devicons = true,
        }
    },
}
-- https://github.com/junegunn/fzf?tab=readme-ov-file#search-syntax
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<leader>vk', builtin.keymaps, {})
