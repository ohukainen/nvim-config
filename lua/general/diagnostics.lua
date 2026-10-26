vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  virtual_text = { source = 'if_many' },
  underline = true,
  signs = true,
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false }
    end,
  },
})
vim.g.diagnostic_hints_shown = true

local switch_hints = function()
  local shown = not vim.g.diagnostic_hints_shown
  vim.g.diagnostic_hints_shown = shown

  local sev
  if not shown then
    sev = { min = vim.diagnostic.severity.WARN }
  end
  vim.diagnostic.config({
    underline = { severity = sev },
    virtual_text = { severity = sev, source = 'if_many' },
    signs = { severity = sev },
  })
  vim.notify('Hint/info diagnostics switched ' .. (shown and 'on' or 'off'))
end
vim.keymap.set('n', '<leader>i', switch_hints, { desc = 'Toggle hint/[I]nfo diagnostics' })
