vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Sets intendation rules for luafiles',
  pattern = 'lua',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Sets intendation rules for specific codebase',
  pattern = {'cpp', 'h', 'hpp', 'cc', 'CMakeLists.txt'},
  callback = function()
    local cwd = vim.fn.getcwd()
    if cwd:match('C:\\src\\work') then
      vim.opt_local.tabstop = 8
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = false
    end
  end,
})
