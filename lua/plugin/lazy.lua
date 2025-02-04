-- NOTE: Bootstrap Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Installed plugins. If it dont fit on one line it gets a file.
require('lazy').setup({
  -- Personal favorites
  require('config.harpoon'),
  { 'mbbill/undotree', config = function() vim.keymap.set('n', '<leader>n', vim.cmd.UndotreeToggle) end },
  { 'tpope/vim-fugitive', config = function() vim.keymap.set('n', '<leader>g', ':Git ') end },

  -- Telescope
  require('config.telescope'),

  -- LSP, Autocomplete and linting
  { 'folke/lazydev.nvim', ft = 'lua', opts = { library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } }, }, }, },
  { 'Bilal2453/luvit-meta', lazy = true },
  require('config.lsp'),
  require('config.autocomplete'),
  require('config.lint'),

  -- Treesitter 
  require('config.treesitter'),

  -- Colorscheme
  require('config.colorscheme'),

  -- Other
  { 'lewis6991/gitsigns.nvim', signcolumn = false },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  require('config.mini'),
})
