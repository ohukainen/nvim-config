vim.pack.add { { src = 'https://github.com/nvim-mini/mini.nvim', version = vim.version.range '*' } }

if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Serves plugins that require nvim-web-devicons, e.g. telescope
  MiniIcons.mock_nvim_web_devicons()
end

local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return '%2l:%-2v'
end
