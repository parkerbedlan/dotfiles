-- https://neovide.dev/configuration.html#cursor-particles
-- vim.g.neovide_cursor_vfx_mode = { "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe" }
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_density = 10


-- https://neovide.dev/faq.html#how-can-i-dynamically-change-the-scale-at-runtime
-- vim.g.neovide_scale_factor = 1.25
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
end)
