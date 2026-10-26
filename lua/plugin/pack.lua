-- NOTE: Build steps for plugins that need one after install or update
local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end

    if name == 'LuaSnip' then
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
      return
    end
  end,
})

-- NOTE: Installed plugins. If it dont fit on one line it gets a file.
-- Personal favorites
require('config.harpoon')
vim.pack.add { 'https://github.com/mbbill/undotree' } vim.keymap.set('n', '<leader>n', vim.cmd.UndotreeToggle)
vim.pack.add { 'https://github.com/tpope/vim-fugitive' } vim.keymap.set('n', '<leader>g', ':Git ')

-- Telescope
require('config.telescope')

-- LSP, Autocomplete and linting
require('config.lsp')
require('config.autocomplete')

-- Treesitter and Visual Aid
require('config.treesitter')

-- Colorscheme
require('config.colorscheme')

-- Other
vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' } require('gitsigns').setup {}
vim.pack.add { 'https://github.com/folke/todo-comments.nvim' } require('todo-comments').setup { signs = false }
require('config.mini')
