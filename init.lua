vim.loader.enable()

require('general')

-- Machine-specific overrides, gitignored
if vim.uv.fs_stat(vim.fn.stdpath('config') .. '/lua/local.lua') then require('local') end

require('plugin.pack')
