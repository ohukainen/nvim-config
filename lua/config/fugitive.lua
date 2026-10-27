vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

vim.keymap.set('n', '<leader>g', ':Git ')

-- Review tool: step through a `:Git difftool` quickfix list with a vertical diff against vim.g.review_base ('' = index, like dv)
local function qf_vdiff(step)
  local qf = vim.fn.getqflist({ idx = 0, size = 0, winid = 0 })
  local idx = qf.idx + step
  if idx < 1 or idx > qf.size then return end
  if qf.winid == 0 then
    vim.cmd('copen')
    qf.winid = vim.fn.getqflist({ winid = 0 }).winid
  end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= qf.winid then pcall(vim.api.nvim_win_close, win, false) end
  end

  vim.api.nvim_set_current_win(qf.winid)
  vim.cmd('cc ' .. idx)
  local file_win = vim.api.nvim_get_current_win()
  vim.diagnostic.enable(false, { bufnr = 0 })
  vim.api.nvim_win_set_height(qf.winid, 10)
  vim.cmd('Gvdiffsplit ' .. (vim.g.review_base or ''))
  vim.api.nvim_set_current_win(file_win)
end

vim.keymap.set('n', ']r', function() qf_vdiff(1) end, { desc = 'Next quickfix change in [R]eview diff' })
vim.keymap.set('n', '[r', function() qf_vdiff(-1) end, { desc = 'Previous quickfix change in [R]eview diff' })
vim.keymap.set('n', '<leader>rr', function() qf_vdiff(0) end, { desc = 'Current quickfix change in [R]eview diff' })
