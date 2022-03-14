local present, nvimtree = pcall(require, "nvim-tree")

if not present then
   return
end

local g = vim.g

vim.o.termguicolors = true

g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 1
g.nvim_tree_gitignore = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 1 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

g.nvim_tree_show_icons = {
   folders = 1,
   files = 1,
   git = 1,
}

g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      deleted = "",
      ignored = "◌",
      renamed = "➜",
      staged = "✓",
      unmerged = "",
      unstaged = "✗",
      untracked = "★",
   },
   folder = {
      default = "",
      empty = "",
      empty_open = "",
      open = "",
      symlink = "",
      symlink_open = "",
   },
}

local default = {
   filters = {
      dotfiles = false,
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard", ".git", "node_modules", ".cache" },
   auto_close = false,
   open_on_tab = false,
   hijack_cursor = true,
   hijack_unnamed_buffer_when_opening = false,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
      ignore_list = { ".git", "node_modules", ".cache", "__pycache__" },
   },
   view = {
      allow_resize = true,
      side = "left",
      width = 25,
      hide_root_folder = true,
   },
   git = {
      enable = true,
      ignore = true,
   },
   actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}

local M = {}

M.setup = function(override_flag)
   if override_flag then
      default = require("core.utils").tbl_override_req("nvim_tree", default)
   end
   nvimtree.setup(default)
end

return M
