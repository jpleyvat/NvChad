require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "S", ":%s//g<Left><Left>", { desc = "replace all" })

map("i", "jk", "<ESC>")

map("v", ">", ">gv", { desc = "visual indent" })
map("v", "<", "<gv", { desc = "visual outdent" })

map("n", "<M-.>", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "move buffer right" })

map("n", "<M-,>", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "move buffer right" })

map("n", "<M-q>", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "move buffer right" })




-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
