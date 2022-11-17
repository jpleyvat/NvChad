local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  if vim.g.vim_version > 7 then
    -- nightly
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    -- stable
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

lspconfig.sumneko_lua.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.pyright.setup {
   on_attach = M.on_attach,

   settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
   }
}

lspconfig.tsserver.setup {
   on_attach = M.on_attach,
   init_options = {
    preferences = {
      disableSuggestions = true,
    },
   },

   settings = {
     compilerOptions= {
        module= "commonjs",
        target= "es6",
        checkJs= false,
      },
      exclude= {
        "node_modules"
      }
   }
}

lspconfig.bashls.setup {
   on_attach = M.on_attach,
}

lspconfig.tailwindcss.setup {
  on_attach = M.on_attach,
}

lspconfig.cssls.setup {
   on_attach = M.on_attach,
}



-- -- requires a file containing user's lspconfigs
-- local addlsp_confs = utils.load_config().plugins.options.lspconfig.setup_lspconf
--
-- if #addlsp_confs ~= 0 then
--    require(addlsp_confs).setup_lsp(M.on_attach, capabilities)
-- end

return M
