-- n, v, i are mode names

local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

   -- map("n", wnav.moveLeft, "<C-w>h")
   -- map("n", wnav.moveRight, "<C-w>l")
   -- map("n", wnav.moveUp, "<C-w>k")
   -- map("n", wnav.moveDown, "<C-w>j")

--   -- =====================================================================================
--   -- Normal mode remaps
--   -- =====================================================================================
--     -------------------------------
--     -- Fold.
--     -------------------------------
--       -- javascript
--       map('', '<leader>z', [[$V%zf]], {silent=true})
--     -------------------------------
--     -- Format.
--     -------------------------------
--       -- javascript
--       map('', '<leader>fm', [[:exec '!standard --fix % &> /dev/null'<CR>]], {silent=true, noremap=true})
--     -------------------------------
--     -- Lint.
--     -------------------------------
--       map('', '<leader>ll', [[:lua vim.diagnostic.show()<CR>]], {silent=true})
--       map('', '<leader>lh', [[:lua vim.diagnostic.hide()<CR>]], {silent=true})
--     -------------------------------
--     -- Git.
--     -------------------------------
--       map('', '<leader>gj', ':Gitsigns next_hunk<CR>', {silent=true, noremap=true})
--       map('', '<leader>gk', ':Gitsigns prev_hunk<CR>', {silent=true, noremap=true})
--       map('', '<leader>gp', ':Gitsigns preview_hunk<CR>', {silent=true, noremap=true})
--       map('', '<leader>gg', ':DiffviewOpen<CR>', {silent=true, noremap=true})
--       map('', '<leader>ge', ':DiffviewClose<CR>', {silent=true, noremap=true})
--       map('', '<leader>gh', ':DiffviewFileHistory<CR>', {silent=true, noremap=true})

--     map('n', '<leader>r', ':NvimTreeRefresh<CR>', {silent = true})
--     -------------------------------
--     -- Replace all is aliased to S.
--     -------------------------------
--      map('', 'S', ':%s//g<Left><Left>', {noremap = true})
--     ---------------------------
--     -- Move section up and down
--     ---------------------------
--     map('n', '<M-j>', 'ddp', {silent = true})
--     map('n', '<M-k>', 'ddkP', {silent = true})
--     -----------------
--     -- Indent outdent
--     -----------------
--     map('n', '>', 'V>', {silent=true})
--     map('n', '<', 'V<', {silent=true})
--     ---------------
--     -- Resize split
--     ---------------
--     map('n', '<C-j>', ':resize-1<CR>', {silent = true})
--     map('n', '<C-k>', ':resize+1<CR>', {silent = true})

--     map('n', '<C-h>', ':vertical resize-1<CR>', {silent = true})
--     map('n', '<C-l>', ':vertical resize+1<CR>', {silent = true})

--     map('n', '<leader>m', ':MaximizerToggle<CR>', {silent = true})
--     -------------
--     -- Vimspector
--     -------------

--     function GotoWindow(window)
--       vim.call('win_gotoid', window)
--       vim.cmd(':MaximizerToggle')
--     end

--     map('n', '<leader>dd', ':call vimspector#Launch()<CR>', {silent = true})
--     map('n', '<leader>de', ':call vimspector#Reset()<CR>', {silent = true})

--     -- Windows
--     map('n', '<leader>dc', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.code)<CR>', {silent = true})
--     map('n', '<leader>dt', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.tagpage)<CR>', {silent = true})
--     map('n', '<leader>dv', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.variables)<CR>', {silent = true}) 
--     map('n', '<leader>dw', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.watches)<CR>', {silent = true}) 
--     map('n', '<leader>ds', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.stack_trace)<CR>', {silent = true})
--     map('n', '<leader>do', '<Cmd>lua GotoWindow(vim.g.vimspector_session_windows.output)<CR>', {silent = true}) 


--     map('n', '<leader>d<space>', ':call vimspector#Continue()<CR>', {silent = true})

--     map('n', '<leader>dl', '<Plug>VimspectorStepInto', {silent = true})
--     map('n', '<leader>dj', '<Plug>VimspectorStepover', {silent = true})

--     map('n', '<leader>dk', '<Plug>VimspectorStepOut', {silent = true})
--     map('n', '<leader>d_', '<Plug>VimspectorRestart', {silent = true})

--     map('n', '<leader>drc', ':call vimspector#RunToCursor()<CR>', {silent = true})

--     -- Breakpoints
--     map('n', '<leader>dbp', ':call vimspector#ToggleBreakpoint()<CR>', {silent = true})
--     -- map('n', '<leader>dbl', ':call vimspector#CleanLineBreakpoint()<CR>', {silent = true})
--     map('n', '<leader>dbc', ':call vimspector#ClearBreakpoints()<CR>', {silent = true})
--     -- map('n', '<leader>dcbp', '<Plug>Vimspector ToggleConditionalBreakpoint', {silent = true})

--     map('n', 'gd', '<Plug>(coc-definition)', {silent = true})
--     -- =====================================================================================
--     -- Visual mode remaps
--     -- =====================================================================================
--     map('v', '>', '>gv', {silent = true})
--     map('v', '<', '<gv', {silent = true})

--     map('v', '(', 'o<ESC>i(<ESC>gvol<ESC>a)<ESC>', {silent = true})
--     map('v', '{', 'o<ESC>i{<ESC>gvol<ESC>a}<ESC>', {silent = true})
--     map('v', '[', 'o<ESC>i[<ESC>gvol<ESC>a]<ESC>', {silent = true})

--     map('v', [["]], [[o<ESC>i"<ESC>gvol<ESC>a"<ESC>]], {silent = true})
--     map('v', [[']], [[o<ESC>i'<ESC>gvol<ESC>a'<ESC>]], {silent = true})
--     map('v', [[`]], [[o<ESC>i`<ESC>gvol<ESC>a`<ESC>]], {silent = true})


--     map('', '<leader>ep', [[:w<CR>:exec '!python3' shellescape(@%, 1)<CR>]], {silent=true})
--     map('', '<leader>en', [[:w<CR>:exec '!node' shellescape(@%, 1)<CR>]], {silent=true})
--     -- map('n', '<leader>', [[:WhichKey '<Space>'<CR>]], {silent})
--    -- end

   local function required_mappings()
      map("n", maps.close_buffer, ":lua require('core.utils').close_buffer() <CR>") -- close  buffer
      map("n", maps.copy_whole_file, ":%y+ <CR>") -- copy whole file content
      map("n", maps.new_buffer, ":enew <CR>") -- new buffer
      map("n", maps.new_tab, ":tabnew <CR>") -- new tabs
      map("n", maps.line_number_toggle, ":set nu! rnu!<CR>") -- toggle numbers
      map("n", maps.relative_number_toggle, ":set rnu! <CR>") -- toggle numbers
      map("n", maps.save_file, ":w <CR>") -- ctrl + s to save file
   end

M.general = {


   i = {

      -- go to  beginning and end
      ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
      ["<C-e>"] = { "<End>", "壟 end of line" },

      -- navigate within insert mode
      ["<C-h>"] = { "<Left>", "  move left" },
      ["<C-l>"] = { "<Right>", " move right" },
      ["<C-j>"] = { "<Down>", " move down" },
      ["<C-k>"] = { "<Up>", " move up" },
   },

   n = {

      -- switch between windows
      ["<C-h>"] = { "<C-w>h", " window left" },
      ["<C-l>"] = { "<C-w>l", " window right" },
      ["<C-j>"] = { "<C-w>j", " window down" },
      ["<C-k>"] = { "<C-w>k", " window up" },

      -- save
      ["<C-s>"] = { "<cmd> w <CR>", "﬚  save file" },

      -- Copy all
      ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },

      -- line numbers
      ["<leader>n"] = { "<cmd> set nu! <CR>", "   toggle line number" },
      ["<leader>rn"] = { "<cmd> set rnu! <CR>", "   toggle relative number" },

      -- update nvchad
      ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "  update nvchad" },

      -- end

      -- check the theme toggler
      -- if nvChad_options.theme_toggler then
      --    map(
      --       "n",
      --       maps.theme_toggler,
      --       ":lua require('nvchad').toggle_theme(require('core.utils').load_config().ui.theme_toggler) <CR>"
      --    )
      -- end
      ["<leader>tt"] = {
         function()
            require("base46").toggle_theme()
         end,

         "   toggle theme",
      },
   },

   t = {
      ["jk"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
   },
}

M.bufferline = {

   n = {
      -- new buffer
      ["<S-b>"] = { "<cmd> enew <CR>", "烙 new buffer" },

      -- cycle through buffers
      ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
      ["<S-Tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },

      -- close buffer + hide terminal buffer
      ["<leader>x"] = {
         function()
            nvchad.close_buffer()
         end,
         "   close buffer",
      },
   },
}

M.comment = {

   -- toggle comment in both modes
   n = {
      ["<leader>/"] = {
         function()
            require("Comment.api").toggle_current_linewise()
         end,

         "蘒  toggle comment",
      },
   },

   v = {
      ["<leader>/"] = {
         "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
         "蘒  toggle comment",
      },
   },
}

M.lspconfig = {
   -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

   n = {
      ["gD"] = {
         function()
            vim.lsp.buf.declaration()
         end,
         "   lsp declaration",
      },

      ["gd"] = {
         function()
            vim.lsp.buf.definition()
         end,
         "   lsp definition",
      },

      ["K"] = {
         function()
            vim.lsp.buf.hover()
         end,
         "   lsp hover",
      },

      ["gi"] = {
         function()
            vim.lsp.buf.implementation()
         end,
         "   lsp implementation",
      },

      ["<C-k>"] = {
         function()
            vim.lsp.buf.signature_help()
         end,
         "   lsp signature_help",
      },

      ["<leader>D"] = {
         function()
            vim.lsp.buf.type_definition()
         end,
         "   lsp definition type",
      },

      ["<leader>ra"] = {
         function()
            vim.lsp.buf.rename()
         end,
         "   lsp rename",
      },

      ["<leader>ca"] = {
         function()
            vim.lsp.buf.code_action()
         end,
         "   lsp code_action",
      },

      ["gr"] = {
         function()
            vim.lsp.buf.references()
         end,
         "   lsp references",
      },

      ["<leader>f"] = {
         function()
            vim.diagnostic.open_float()
         end,
         "   floating diagnostic",
      },

      ["[d"] = {
         function()
            vim.diagnostic.goto_prev()
         end,
         "   goto prev",
      },

      ["d]"] = {
         function()
            vim.diagnostic.goto_next()
         end,
         "   goto_next",
      },

      ["<leader>q"] = {
         function()
            vim.diagnostic.setloclist()
         end,
         "   diagnostic setloclist",
      },

      ["<leader>fm"] = {
         function()
            vim.lsp.buf.formatting()
         end,
         "   lsp formatting",
      },

      ["<leader>wa"] = {
         function()
            vim.lsp.buf.add_workspace_folder()
         end,
         "   add workspace folder",
      },

      ["<leader>wr"] = {
         function()
            vim.lsp.buf.remove_workspace_folder()
         end,
         "   remove workspace folder",
      },

      ["<leader>wl"] = {
         function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         "   list workspace folders",
      },
   },
}

M.nvimtree = {

   n = {
      -- toggle
      ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },

      -- focus
      ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
   },
}

M.telescope = {
   n = {
      -- find
      ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
      ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
      ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
      ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
      ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
      ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
      ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

      -- git
      ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
      ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "  git status" },

      -- pick a hidden term
      ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },

      -- theme switcher
      ["<leader>th"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
   },
}

M.nvterm = {
   t = {
      -- toggle in terminal mode
      ["<A-i>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   toggle floating term",
      },

      ["<A-h>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   toggle horizontal term",
      },

      ["<A-v>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   toggle vertical term",
      },
   },

   n = {
      -- toggle in normal mode
      ["<A-i>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   toggle floating term",
      },

      ["<A-h>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   toggle horizontal term",
      },

      ["<A-v>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   toggle vertical term",
      },

      -- new

      ["<leader>h"] = {
         function()
            require("nvterm.terminal").new "horizontal"
         end,
         "   new horizontal term",
      },

      ["<leader>v"] = {
         function()
            require("nvterm.terminal").new "vertical"
         end,
         "   new vertical term",
      },
   },
}

M.whichkey = {
   n = {
      ["<leader>wK"] = {
         function()
            vim.cmd "WhichKey"
         end,
         "   which-key all keymaps",
      },
      ["<leader>wk"] = {
         function()
            local input = vim.fn.input "WhichKey: "
            vim.cmd("WhichKey " .. input)
         end,
         "   which-key query lookup",
      },
   },
}

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
