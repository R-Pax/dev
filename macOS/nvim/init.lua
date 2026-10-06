vim.g.mapleader = " "
require("pax.lazy")
require("pax")

vim.g.netrw_list_hide = [[^\.DS_Store$]]
vim.g.netrw_banner = 0

-- Cmd+S writes (needs Ghostty helper)
vim.keymap.set({ "n", "i" }, "<F15>", "<cmd>write<CR>", { desc = "Save file" })
