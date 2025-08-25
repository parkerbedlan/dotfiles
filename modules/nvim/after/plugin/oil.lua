-- https://github.com/stevearc/oil.nvim?tab=readme-ov-file#options
require("oil").setup({
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = false,
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = false,
        ["<C-c>"] = "actions.close",
        ["gr"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["<C-l>"] = false,
    },
    view_options = {
        show_hidden = true
    },
    columns = {
        -- "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },

})
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
vim.keymap.set("n", "-", vim.cmd.Oil)
