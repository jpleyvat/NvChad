local utils = require "core.utils"

local config = utils.load_config()
local map_wrapper = utils.map

local maps = config.mappings
local plugin_maps = maps.plugins
local nvChad_options = config.options.nvChad

local cmd = vim.cmd

-- This is a wrapper function made to disable a plugin mapping from chadrc
-- If keys are nil, false or empty string, then the mapping will be not applied
-- Useful when one wants to use that keymap for any other purpose
local map = function(...)
   local keys = select(2, ...)
   if not keys or keys == "" then
      return
   end
   map_wrapper(...)
end

local M = {}

-- these mappings will only be called during initialization

M.misc = function()
   local function non_config_mappings()
      -- Don't copy the replaced text after pasting in visual mode
      map_wrapper("v", "p", "p:let @+=@0<CR>")

      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      -- empty mode is same as using :map
      -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
      map_wrapper("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
      map_wrapper("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
      map_wrapper("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
      map_wrapper("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

      -- use ESC to turn off search highlighting
      map_wrapper("n", "<Esc>", ":noh <CR>")

      -- center cursor when moving (goto_definition)

      -- yank from current cursor to end of line
      map_wrapper("n", "Y", "yg$")
   end

   local function optional_mappings()
      -- don't yank text on cut ( x )
      if not nvChad_options.copy_cut then
         map_wrapper({ "n", "v" }, "x", '"_x')
      end

      -- don't yank text on delete ( dd )
      if not nvChad_options.copy_del then
         map_wrapper({ "n", "v" }, "d", '"_d')
      end

      -- navigation within insert mode
      if nvChad_options.insert_nav then
         local inav = maps.insert_nav

         map("i", inav.backward, "<Left>")
         map("i", inav.end_of_line, "<End>")
         map("i", inav.forward, "<Right>")
         map("i", inav.next_line, "<Up>")
         map("i", inav.prev_line, "<Down>")
         map("i", inav.beginning_of_line, "<ESC>^i")
      end

      -- easier navigation between windows
      if nvChad_options.window_nav then
         local wnav = maps.window_nav

         map("n", wnav.moveLeft, "<C-w>h")
         map("n", wnav.moveRight, "<C-w>l")
         map("n", wnav.moveUp, "<C-w>k")
         map("n", wnav.moveDown, "<C-w>j")
      end

      -- check the theme toggler
      if nvChad_options.theme_toggler then
         map(
            "n",
            maps.theme_toggler,
            ":lua require('nvchad').toggle_theme(require('core.utils').load_config().ui.theme_toggler) <CR>"
         )
      end
  -- =====================================================================================
  -- Normal mode remaps
  -- =====================================================================================
    -------------------------------
    -- Fold.
    -------------------------------
      -- javascript
      map('', '<leader>z', [[$V%zf]], {silent=true})
    -------------------------------
    -- Format.
    -------------------------------
      -- javascript
      map('', '<leader>fm', [[:exec '!standard --fix % &> /dev/null'<CR>]], {silent=true, noremap=true})
    -------------------------------
    -- Lint.
    -------------------------------
      map('', '<leader>ll', [[:lua vim.diagnostic.show()<CR>]], {silent=true})
      map('', '<leader>lh', [[:lua vim.diagnostic.hide()<CR>]], {silent=true})
    -------------------------------
    -- Git.
    -------------------------------
      map('', '<leader>gj', ':Gitsigns next_hunk<CR>', {silent=true, noremap=true})
      map('', '<leader>gk', ':Gitsigns prev_hunk<CR>', {silent=true, noremap=true})
      map('', '<leader>gp', ':Gitsigns preview_hunk<CR>', {silent=true, noremap=true})
      map('', '<leader>gg', ':DiffviewOpen<CR>', {silent=true, noremap=true})
      map('', '<leader>ge', ':DiffviewClose<CR>', {silent=true, noremap=true})
      map('', '<leader>gh', ':DiffviewFileHistory<CR>', {silent=true, noremap=true})

    map('n', '<leader>r', ':NvimTreeRefresh<CR>', {silent = true})
    -------------------------------
    -- Replace all is aliased to S.
    -------------------------------
     map('', 'S', ':%s//g<Left><Left>', {noremap = true})
    ---------------------------
    -- Move section up and down
    ---------------------------
    map('n', '<M-j>', 'ddp', {silent = true})
    map('n', '<M-k>', 'ddkP', {silent = true})
    -----------------
    -- Indent outdent
    -----------------
    map('n', '>', 'V>', {silent=true})
    map('n', '<', 'V<', {silent=true})
    ---------------
    -- Resize split
    ---------------
    map('n', '<C-j>', ':resize-1<CR>', {silent = true})
    map('n', '<C-k>', ':resize+1<CR>', {silent = true})

    map('n', '<C-h>', ':vertical resize-1<CR>', {silent = true})
    map('n', '<C-l>', ':vertical resize+1<CR>', {silent = true})

    map('n', '<leader>m', ':MaximizerToggle<CR>', {silent = true})
    -------------
    -- Vimspector
    -------------

    function GotoWindow(window)
      vim.call('win_gotoid', window)
      vim.cmd(':MaximizerToggle')
    end

    map('n', '<leader>dd', ':call vimspector#Launch()<CR>', {silent = true})
    map('n', '<leader>de', ':call vimspector#Reset()<CR>', {silent = true})

    -- Windows
    map('n', '<leader>dc', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.code)<CR>', {silent = true})
    map('n', '<leader>dt', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.tagpage)<CR>', {silent = true})
    map('n', '<leader>dv', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.variables)<CR>', {silent = true}) 
    map('n', '<leader>dw', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.watches)<CR>', {silent = true}) 
    map('n', '<leader>ds', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.stack_trace)<CR>', {silent = true})
    map('n', '<leader>do', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.output)<CR>', {silent = true}) 


    map('n', '<leader>d<space>', ':call vimspector#Continue()<CR>', {silent = true})

    map('n', '<leader>dl', '<Plug>VimspectorStepInto', {silent = true})
    map('n', '<leader>dj', '<Plug>VimspectorStepover', {silent = true})

    map('n', '<leader>dk', '<Plug>VimspectorStepOut', {silent = true})
    map('n', '<leader>d_', '<Plug>VimspectorRestart', {silent = true})

    map('n', '<leader>drc', ':call vimspector#RunToCursor()<CR>', {silent = true})

    -- Breakpoints
    map('n', '<leader>dbp', ':call vimspector#ToggleBreakpoint()<CR>', {silent = true})
    -- map('n', '<leader>dbl', ':call vimspector#CleanLineBreakpoint()<CR>', {silent = true})
    map('n', '<leader>dbc', ':call vimspector#ClearBreakpoints()<CR>', {silent = true})
    -- map('n', '<leader>dcbp', '<Plug>Vimspector ToggleConditionalBreakpoint', {silent = true})

    map('n', 'gd', '<Plug>(coc-definition)', {silent = true})
    -- =====================================================================================
    -- Visual mode remaps
    -- =====================================================================================
    map('v', '>', '>gv', {silent = true})
    map('v', '<', '<gv', {silent = true})

    map('v', '(', 'o<ESC>i(<ESC>gvol<ESC>a)<ESC>', {silent = true})
    map('v', '{', 'o<ESC>i{<ESC>gvol<ESC>a}<ESC>', {silent = true})
    map('v', '[', 'o<ESC>i[<ESC>gvol<ESC>a]<ESC>', {silent = true})

    map('v', [["]], [[o<ESC>i"<ESC>gvol<ESC>a"<ESC>]], {silent = true})
    map('v', [[']], [[o<ESC>i'<ESC>gvol<ESC>a'<ESC>]], {silent = true})
    map('v', [[`]], [[o<ESC>i`<ESC>gvol<ESC>a`<ESC>]], {silent = true})


    map('', '<leader>ep', [[:w<CR>:exec '!python3' shellescape(@%, 1)<CR>]], {silent=true})
    map('', '<leader>en', [[:w<CR>:exec '!node' shellescape(@%, 1)<CR>]], {silent=true})
    -- map('n', '<leader>', [[:WhichKey '<Space>'<CR>]], {silent})
   end

   local function required_mappings()
      map("n", maps.close_buffer, ":lua require('core.utils').close_buffer() <CR>") -- close  buffer
      map("n", maps.copy_whole_file, ":%y+ <CR>") -- copy whole file content
      map("n", maps.new_buffer, ":enew <CR>") -- new buffer
      map("n", maps.new_tab, ":tabnew <CR>") -- new tabs
      map("n", maps.line_number_toggle, ":set nu! rnu!<CR>") -- toggle numbers
      map("n", maps.relative_number_toggle, ":set rnu! <CR>") -- toggle numbers
      map("n", maps.save_file, ":w <CR>") -- ctrl + s to save file
   end

   local function required_mappings()
      map("n", maps.misc.cheatsheet, ":lua require('nvchad.cheatsheet').show() <CR>") -- show keybinds
      map("n", maps.misc.close_buffer, ":lua require('core.utils').close_buffer() <CR>") -- close  buffer
      map("n", maps.misc.cp_whole_file, ":%y+ <CR>") -- copy whole file content
      map("n", maps.misc.new_buffer, ":enew <CR>") -- new buffer
      map("n", maps.misc.new_tab, ":tabnew <CR>") -- new tabs
      map("n", maps.misc.lineNR_toggle, ":set nu! <CR>")
      map("n", maps.misc.lineNR_rel_toggle, ":set rnu! <CR>") -- relative line numbers
      map("n", maps.misc.save_file, ":w <CR>") -- ctrl + s to save file

      -- terminal mappings --
      local term_maps = maps.terminal
      -- get out of terminal mode
      map("t", term_maps.esc_termmode, "<C-\\><C-n>")
      -- hide a term from within terminal mode
      map("t", term_maps.esc_hide_termmode, "<C-\\><C-n> :lua require('core.utils').close_buffer() <CR>")
      -- pick a hidden term
      map("n", term_maps.pick_term, ":Telescope terms <CR>")
      -- Open terminals
      -- TODO this opens on top of an existing vert/hori term, fixme
      map("n", term_maps.new_horizontal, ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
      map("n", term_maps.new_vertical, ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
      map("n", term_maps.new_window, ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")
      -- terminal mappings end --

      -- Add Packer commands because we are not loading it at startup
      cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
      cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
      cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
      cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
      cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
      cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"

      -- add NvChadUpdate command and mapping
      cmd "silent! command! NvChadUpdate lua require('nvchad').update_nvchad()"
      map("n", maps.misc.update_nvchad, ":NvChadUpdate <CR>")
   end

   non_config_mappings()
   optional_mappings()
   required_mappings()
end

-- below are all plugin related mappings

M.bufferline = function()
   local m = plugin_maps.bufferline
   
  --Buffer close
   map('n', '<A-q>', ':bd<CR>', {silent=true})
   map('n', '<leader>q', ':bd<CR>', {silent=true})
  -- Move through buffers.
   map('n', '<A-,>', ':BufferLineCyclePrev<CR>', {silent=true})
   map('n', '<A-.>', ':BufferLineCycleNext<CR>', {silent=true})

end

M.chadsheet = function()
   local m = plugin_maps.chadsheet

   map("n", m.default_keys, ":lua require('cheatsheet').show_cheatsheet_telescope() <CR>")
   map(
      "n",
      m.user_keys,
      ":lua require('cheatsheet').show_cheatsheet_telescope{bundled_cheatsheets = false, bundled_plugin_cheatsheets = false } <CR>"
   )
end

M.comment = function()
   local m = plugin_maps.comment.toggle
   map("n", m, ":lua require('Comment.api').toggle_current_linewise()<CR>")
   map("v", m, ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
end

M.lspconfig = function()
   local m = plugin_maps.lspconfig

   -- See `:help vim.lsp.*` for documentation on any of the below functions
   map("n", m.declaration, "<cmd>lua vim.lsp.buf.declaration()<CR>")
   map("n", m.definition, "<cmd>lua vim.lsp.buf.definition()<CR>")
   map("n", m.hover, "<cmd>lua vim.lsp.buf.hover()<CR>")
   map("n", m.implementation, "<cmd>lua vim.lsp.buf.implementation()<CR>")
   map("n", m.signature_help, "<cmd>lua vim.lsp.buf.signature_help()<CR>")
   map("n", m.add_workspace_folder, "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
   map("n", m.remove_workspace_folder, "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
   map("n", m.list_workspace_folders, "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
   map("n", m.type_definition, "<cmd>lua vim.lsp.buf.type_definition()<CR>")
   map("n", m.rename, "<cmd>lua vim.lsp.buf.rename()<CR>")
   map("n", m.code_action, "<cmd>lua vim.lsp.buf.code_action()<CR>")
   map("n", m.references, "<cmd>lua vim.lsp.buf.references()<CR>")
   map("n", m.float_diagnostics, "<cmd>lua vim.diagnostic.open_float()<CR>")
   map("n", m.goto_prev, "<cmd>lua vim.diagnostic.goto_prev()<CR>")
   map("n", m.goto_next, "<cmd>lua vim.diagnostic.goto_next()<CR>")
   map("n", m.set_loclist, "<cmd>lua vim.diagnostic.setloclist()<CR>")
   map("n", m.formatting, "<cmd>lua vim.lsp.buf.formatting()<CR>")
end

M.nvimtree = function()
   map("n", plugin_maps.nvimtree.toggle, ":NvimTreeToggle <CR>")
   -- map("n", plugin_maps.nvimtree.focus, ":NvimTreeFocus <CR>")
end

-- M.neoformat = function()
--    map("n", plugin_maps.neoformat.format, ":Neoformat <CR>")
-- end

M.telescope = function()
   local m = plugin_maps.telescope

   map("n", m.buffers, ":Telescope buffers <CR>")
   map("n", m.find_files, ":Telescope find_files <CR>")
   map("n", m.find_hiddenfiles, ":Telescope find_files follow=true no_ignore=true hidden=true <CR>")
   map("n", m.git_commits, ":Telescope git_commits <CR>")
   map("n", m.git_status, ":Telescope git_status <CR>")
   map("n", m.help_tags, ":Telescope help_tags <CR>")
   map("n", m.live_grep, ":Telescope live_grep <CR>")
   map("n", m.oldfiles, ":Telescope oldfiles <CR>")
   map("n", m.themes, ":Telescope themes <CR>")
end

M.telescope_media = function()
   local m = plugin_maps.telescope.telescope_media

   map("n", m.media_files, ":Telescope media_files <CR>")
end

M.truezen = function()
   local m = plugin_maps.truezen

   map("n", m.ataraxis_mode, ":TZAtaraxis <CR>")
   map("n", m.focus_mode, ":TZFocus <CR>")
   map("n", m.minimalistic_mode, ":TZMinimalist <CR>")
end

return M
