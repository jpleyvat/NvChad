-- n, v, i, t = mode names

local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {

   i = {
      -- go to  beginning and end
      ["<C-b>"] = { "<ESC>^i", "  beginning of line" },
      ["<C-e>"] = { "<End>", "壟 end of line" },

      -- navigate within insert mode
      ["<C-h>"] = { "<Left>", "  move left" },
      ["<C-l>"] = { "<Right>", " move right" },
      ["<C-j>"] = { "<Down>", " move down" },
      ["<C-k>"] = { "<Up>", " move up" },
   },

   n = {

      ["<ESC>"] = { "<cmd> noh <CR>", "  no highlight" },

      -- switch between windows
      -- ["<C-h>"] = { "<C-w>h", " window left" },
      -- ["<C-l>"] = { "<C-w>l", " window right" },
      -- ["<C-j>"] = { "<C-w>j", " window down" },
      -- ["<C-k>"] = { "<C-w>k", " window up" },

      -- save
      ["<C-s>"] = { "<cmd> w <CR>", "﬚  save file" },

      -- Copy all
      ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },

      -- line numbers
      ["<leader>nn"] = { "<cmd> set nornu nonu <CR>", "   toggle line number" },
      ["<leader>nu"] = { "<cmd> set nornu nu! <CR>", "   toggle line number" },
      ["<leader>nr"] = { "<cmd> set nonu rnu! <CR>", "   toggle relative number" },

      -- update nvchad
      ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "  update nvchad" },

      ["<leader>tt"] = {
         function()
            require("base46").toggle_theme()
         end,

         "   toggle theme",
      },

      ["<leader>z"] = { "[[$V%zf]]", "祉" },

      ["<leader>fp"] = { ":exec '!black %'<CR>", " format" },
      ["<leader>fs"] = { ":exec '!standard --fix %'<CR>", " format" },
      ["<leader>ft"] = { ":exec '!ts-standard --fix %'<CR>", " format" },

      -- Git
      ['<leader>gj'] = { ':Gitsigns next_hunk<CR>', '  hunk ' },
      ['<leader>gk'] = { ':Gitsigns prev_hunk<CR>', '  hunk ' },

      ['<leader>gs'] = { ':Gitsigns sign_hunk<CR>', '  hunk sign' },
      ['<leader>gr'] = { ':Gitsigns reset_hunk<CR>', '  hunk reset' },

      ['<leader>gp'] = { ':Gitsigns preview_hunk<CR>', '  preview' },
      ['<leader>gg'] = { ':DiffviewOpen<CR>', '  繁 open' },
      ['<leader>ge'] = { ':DiffviewClose<CR>', '  繁 close' },
      ['<leader>gh'] = { ':DiffviewFileHistory<CR>', '  diff history' },

      ['S'] = {':%s//g<Left><Left>', ' replace all'},

      ['<leader>ep'] = {":w<CR>:exec '!python3' shellescape(@%, 1)<CR>", '  '},


    ['<leader>r']  = { ':NvimTreeRefresh<CR>', ' refresh nvimtree'},

    ['<M-j>'] = { 'ddp', ' move line down' },
    ['<M-k>'] = { 'ddkP', ' move line up' },

    -----------------
    -- Indent outdent
    -----------------
    ['>'] = { 'V>', '' },
    ['<'] = { 'V<', '' },

    ---------------
    -- Resize split
    ---------------
    ['<C-j>'] = { ':resize-1<CR>', ' shrink' },
    ['<C-k>'] = { ':resize+1<CR>', ' grow' },

    ['<C-h>'] = { ':vertical resize-1<CR>', '  vertical shrink' },
    ['<C-l>'] = { ':vertical resize+1<CR>', ' vertical grow' },

    ['<leader>m'] = {':MaximizerToggle<CR>', '' },

   },
   v = {
    ['>'] = {'>gv', ' visual indent'},
    ['<'] = {'<gv', ' visual outdent'},
   },

   t = {
      ["<C-x>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
   },
}

M.tabufline = {

   n = {
      -- new buffer
      ["<S-b>"] = { "<cmd> enew <CR>", "烙 new buffer" },

      -- cycle through buffers
      -- ["<TAB>"] = { "<cmd> Tbufnext <CR>", "  goto next buffer" },
      -- ["<S-Tab>"] = { "<cmd> Tbufprev <CR> ", "  goto prev buffer" },

      ["<M-.>"] = { "<cmd> Tbufnext <CR>", "  cycle next buffer" },
      ["<M-,>"] = { "<cmd> Tbufprev <CR>", "  cycle prev buffer" },


      -- cycle through tabs
      -- ["<leader>tp"] = { "<cmd> tabprevious <CR>", "  goto next tab" },
      -- ["<leader>tn"] = { "<cmd> tabnext <CR> ", "  goto prev tab" },

      -- close buffer + hide terminal buffer
      -- ["<leader>x"] = {
      --    function()
      --       require("core.utils").close_buffer()
      --    end,
      --    "   close buffer",
      -- },

      ["<M-q>"] = {
         function()
            require("core.utils").close_buffer()
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

      ["<leader>ls"] = {
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
            require("nvchad.ui.renamer").open()
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
      -- ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
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

function GotoWindow(window)
  vim.call('win_gotoid', window)
  vim.cmd(':MaximizerToggle')
end

M.vimspector = {
    n = {
      ['<leader>dd'] = {':call vimspector#Launch()<CR>', ''},
      ['<leader>de'] = {':call vimspector#Reset()<CR>', ' reset'},
      ['<leader>d<space>'] = {':call vimspector#Continue()<CR>', ' 怜'},

      ['<leader>dbp'] = {':call vimspector#ToggleBreakpoint()<CR>', ' toggle breakpoint'},
      ['<leader>dbc'] = {':call vimspector#ClearBreakpoints()<CR>', ' clear breakpoints'},
      ['<leader>dbl'] = {':call vimspector#CleanLineBreakpoint()<CR>', ' clean breakpoints'},

      ['<leader>dl'] = {'<Plug>VimspectorStepInto', ''},
      ['<leader>dj'] = {'<Plug>VimspectorStepover', ''},

      ['<leader>dk'] = {'<Plug>VimspectorStepOut', ''},
      ['<leader>d_'] = {'<Plug>VimspectorRestart', ''},

      ['<leader>drc'] = {':call vimspector#RunToCursor()<CR>', ''},
      ['<leader>dcbp'] = {'<Plug>Vimspector ToggleConditionalBreakpoint', ' toggle conditional breakpoint'},

      ["<leader>dc"] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.code)]]
        end,
        "   ",
      },
      ['<leader>dt'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.tagpage)]]
        end,
        "  tag ",
      },
      ['<leader>dv'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.variables)]]
        end,
        "  variables ",
      },
      ['<leader>dw'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.watches)]]
        end,
        "  watches ",
      },
      ['<leader>ds'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.stack_trace)]]
        end,
        "  stack ",
      },
      ['<leader>do'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.output)]]
        end,
        "   ",
      },
    },
}

M.blankline = {
   n = {
      ["<leader>bc"] = {
         function()
            local ok, start = require("indent_blankline.utils").get_current_context(
               vim.g.indent_blankline_context_patterns,
               vim.g.indent_blankline_use_treesitter_scope
            )

            if ok then
               vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
               vim.cmd [[normal! _]]
            end
         end,

         "  Jump to current_context",
      },
   },
}

return M
