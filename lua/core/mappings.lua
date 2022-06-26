-- n, v, i are mode names

local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local formatters = {
  ['javascript'] = ":exec '!standard --fix % &> /dev/null'<CR>",
  ['typescript'] = ":exec '!ts-standard --fix % &> /dev/null'<CR>",
  ['typescriptreact'] = ":exec '!ts-standard --fix % &> /dev/null'<CR>"
}

local M = {}

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

      ["<leader>z"] = { "[[$V%zf]]", "論 fold" },

      ["<leader>fs"] = { ":exec '!standard --fix % &> /dev/null'<CR>", "論 format standard" },
      ["<leader>ft"] = { ":exec '!ts-standard --fix % &> /dev/null'<CR>", "論 format tsstandard" },
      ["<leader>fp"] = { ":exec '!prettier --write % &> /dev/null'<CR>", "論 format prettier" },

      -- Git
      ['<leader>gj'] = { ':Gitsigns next_hunk<CR>', '論 git hunk down' },
      ['<leader>gk'] = { ':Gitsigns prev_hunk<CR>', '論 git hunk up' },

      ['<leader>gs'] = { ':Gitsigns sign_hunk<CR>', '論 git hunk sign' },
      ['<leader>gr'] = { ':Gitsigns reset_hunk<CR>', '論 git hunk reset' },

      ['<leader>gp'] = { ':Gitsigns preview_hunk<CR>', '論git preview' },
      ['<leader>gg'] = { ':DiffviewOpen<CR>', '論git diff open' },
      ['<leader>ge'] = { ':DiffviewClose<CR>', '論git diff close' },
      ['<leader>gh'] = { ':DiffviewFileHistory<CR>', '論git diff history' },

      ['S'] = {':%s//g<Left><Left>', '論replace all'},

      ['<leader>ep'] = {":w<CR>:exec '!python3' shellescape(@%, 1)<CR>", '論execute python'},


    ['<leader>r']  = { ':NvimTreeRefresh<CR>', '論refresh nvimtree'},

    ['<M-j>'] = { 'ddp', '論move line down' },
    ['<M-k>'] = { 'ddkP', '論move line up' },

    -----------------
    -- Indent outdent
    -----------------
    ['>'] = { 'V>', '論 indent' },
    ['<'] = { 'V<', '論 outdent' },

    ---------------
    -- Resize split
    ---------------
    ['<C-j>'] = { ':resize-1<CR>', '論shrink' },
    ['<C-k>'] = { ':resize+1<CR>', '論grow' },

    ['<C-h>'] = { ':vertical resize-1<CR>', '論vertical shrink' },
    ['<C-l>'] = { ':vertical resize+1<CR>', '論vertical grow' },

    ['<leader>m'] = {':MaximizerToggle<CR>', '論toggle miximize' },

   },
   v = {
    ['>'] = {'>gv', '論visual indent'},
    ['<'] = {'<gv', '論visual outdent'},
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
      -- ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
      -- ["<S-Tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
      ["<M-.>"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
      ["<M-,>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },

      -- close buffer + hide terminal buffer
      ["<leader>x"] = {
         function()
            nvchad.close_buffer()
         end,
         "   close buffer",
      },

      ["<M-q>"] = {
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
      ['<leader>dd'] = {':call vimspector#Launch()<CR>', 'launch vimspector'},
      ['<leader>de'] = {':call vimspector#Reset()<CR>', 'reset vimspector'},
      ['<leader>d<space>'] = {':call vimspector#Continue()<CR>', 'continue vimspector'},

      ['<leader>dbp'] = {':call vimspector#ToggleBreakpoint()<CR>', ''},
      ['<leader>dbc'] = {':call vimspector#ClearBreakpoints()<CR>', ''},
      ['<leader>dbl'] = {':call vimspector#CleanLineBreakpoint()<CR>', ''},

      ['<leader>dl'] = {'<Plug>VimspectorStepInto', ''},
      ['<leader>dj'] = {'<Plug>VimspectorStepover', ''},

      ['<leader>dk'] = {'<Plug>VimspectorStepOut', ''},
      ['<leader>d_'] = {'<Plug>VimspectorRestart', ''},

      ['<leader>drc'] = {':call vimspector#RunToCursor()<CR>', ''},
      ['<leader>dcbp'] = {'<Plug>Vimspector ToggleConditionalBreakpoint', ''},

      ["<leader>dc"] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.code)]]
        end,
        "   toggle vimspector",
      },
      ['<leader>dt'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.tagpage)]]
        end,
        "   toggle vimspector",
      },
      ['<leader>dv'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.variables)]]
        end,
        "   toggle vimspector",
      },
      ['<leader>dw'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.watches)]]
        end,
        "   toggle vimspector",
      },
      ['<leader>ds'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.stack_trace)]]
        end,
        "   toggle vimspector",
      },
      ['<leader>do'] = {
        function()
            vim.cmd [[:lua GotoWindow(vim.g.vimspector_session_windows.output)]]
        end,
        "   toggle vimspector",
      },
    },
}

return M
