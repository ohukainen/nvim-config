return {
  -- NOTE: Im trying out a light theme cause i hate my eyes
  'folke/tokyonight.nvim',
  init = function()
    vim.cmd.colorscheme('tokyonight-day')

    -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

    -- vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'none', fg = 'none' })
    -- vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'none', fg = 'none' })

    -- vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none', fg = 'none' })
  end,
}
