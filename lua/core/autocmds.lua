local autocmd = vim.api.nvim_create_autocmd

-- Disable statusline in dashboard
autocmd("FileType", {
   pattern = "alpha",
   callback = function()
      vim.opt.laststatus = 0
   end,
})

autocmd("BufUnload", {
   buffer = 0,
   callback = function()
      vim.opt.laststatus = 3
   end,
})

-- open nvim with a dir while still lazy loading nvimtree
-- autocmd("BufEnter", {
--    callback = function()
--       if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
--          vim.cmd "lcd %:p:h"
--       end
--    end,
-- })

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- autocmd("InsertEnter", {
--    callback = function()
--       vim.opt.relativenumber = false
--    end,
-- })
-- autocmd("InsertLeave", {
--    callback = function()
--       vim.opt.relativenumber = true
--    end,
-- })

-- Open a file from its last left off position
-- autocmd("BufReadPost", {
--    callback = function()
--       if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
--          vim.cmd "normal! g'\""
--          vim.cmd "normal zz"
--       end
--    end,
-- })

-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]


-- default filetype
-- vim.cmd [[
--   let g:do_filetype = 0
--   au BufWinEnter,BufAdd * if expand('<afile>') == "" | let g:do_filetype = 1 | endif
--   au BufEnter vimspector.* if g:do_filetype | set syntax=javascript | endif
-- ]]

-- vim.cmd [[
--   augroup formatting 
--     autocmd!
--     autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown
--     autocmd FileType css setlocal formatprg=prettier\ --parser\ css
--     autocmd FileType html setlocal formatprg=prettier\ --parser\ html
--     autocmd FileType json setlocal formatprg=prettier\ --parser\ json
--     autocmd FileType javascript setlocal formatprg=standard\ --fix\ &>\ /dev/null\ %
--   augroup END
--
--   " format entire buffer and keep cursor position with mark
--   nnoremap <silent><leader>fm mxgggqG'x<CR>
--
-- ]]

-- vim.cmd[[let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '__pycache__', 'venv'] "empty by default]]
