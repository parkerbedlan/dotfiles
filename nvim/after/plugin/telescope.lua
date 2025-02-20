local telescope = require('telescope')
telescope.setup {
    defaults = {
        layout_strategy = "vertical"
        -- layout_config = { height=0.95 }
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
}
-- https://github.com/junegunn/fzf?tab=readme-ov-file#search-syntax
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
