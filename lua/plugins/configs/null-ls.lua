local present, null_ls = pcall(require, "null-ls")
-- local null_ls = require "null-ls"
local b = null_ls.builtins

if not present then
    echo("null-ls not found")
   return
end

local sources = {
   -- Javascript
   b.diagnostics.standardjs,
   b.formatting.prettier,

   b.formatting.prettierd.with { filetypes = { "html", "markdown", "css" } },
   b.formatting.deno_fmt,

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

null_ls.setup {
  debug = true,
  sources = sources,
}
