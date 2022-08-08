-- Chadrc overrides this file

local M = {}

M.options = {
   -- load your options here or load module with options
   user = function()
      local enable_providers = {
         "python3_provider",
         "node_provider",
         -- and so on
       }
       for _, plugin in pairs(enable_providers) do
         vim.g["loaded_" .. plugin] = nil
         vim.cmd("runtime " .. plugin)
       end
   end,

   nvChad = {
      update_url = "https://github.com/NvChad/NvChad",
      update_branch = "main",
   },
}

M.ui = {
   -- hl = highlights
   hl_add = {},
   hl_override = {},
   changed_themes = {},
   theme_toggle = { "onedark", "one_light" },
   theme = "onedark", -- default theme
   transparency = false,
}

M.plugins = {
   override = {},
   remove = {},
   user = {},
   options = {
      lspconfig = {
         setup_lspconf = "", -- path of lspconfig file
      },
   },
}

-- check core.mappings for table structure
M.mappings = require "core.mappings"

return M
