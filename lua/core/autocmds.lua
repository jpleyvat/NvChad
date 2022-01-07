-- uncomment this if you want to open nvim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd[[ au InsertEnter * set norelativenumber ]]
-- vim.cmd[[ au InsertLeave * set relativenumber ]]

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- Don't show status line on certain windows
vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require("core.utils").hide_statusline() ]]

-- Open a file from its last left off position
-- vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]


vim.cmd [[
  " default filetype
  let g:do_filetype = 0
  au BufWinEnter,BufAdd * if expand('<afile>') == "" | let g:do_filetype = 1 | endif
  au BufEnter vimspector.* if g:do_filetype | setf python | endif
]]

vim.cmd [[
  augroup formatting 
    autocmd!
    autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown
    autocmd FileType css setlocal formatprg=prettier\ --parser\ css
    autocmd FileType html setlocal formatprg=prettier\ --parser\ html
    autocmd FileType json setlocal formatprg=prettier\ --parser\ json
    autocmd FileType javascript setlocal formatprg=standard\ --fix\ %
  augroup END

  " format entire buffer and keep cursor position with mark
  nnoremap <silent><leader>fm mxgggqG'x<CR>

]]

-- vim.cmd[[let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '__pycache__', 'venv'] "empty by default]]
