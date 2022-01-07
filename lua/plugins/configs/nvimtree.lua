local present, nvimtree = pcall(require, "nvim-tree")

local conf = require("core.utils").load_config().plugins.options.nvimtree

local git_status = conf.enable_git
local ui = conf.ui

if not present then
   return
end

local g = vim.g

vim.o.termguicolors = true

g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = git_status
g.nvim_tree_gitignore = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 1 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

g.nvim_tree_window_picker_exclude = {
   filetype = { "notify", "packer", "qf" },
   buftype = { "terminal" },
}

g.nvim_tree_show_icons = {
   folders = 1,
   files = 1,
   git = git_status,
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

nvimtree.setup {
   filters = {
      dotfiles = false,
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard", ".git", "node_modules", ".cache" },
   auto_close = true,
   open_on_tab = false,
   hijack_cursor = true,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
      ignore_list = { ".git", "node_modules", ".cache" },
   },
   view = {
      allow_resize = true,
      auto_resize = false,
      side = "left",
      width = 25,
   },
}