---@diagnostic disable-next-line: duplicate-set-field
require('editorconfig').properties.insert_final_newline = function(bufnr, value, _)
  if value == 'true' then
    vim.bo[bufnr].fixendofline = true
  else
    vim.bo[bufnr].fixendofline = false
  end
end
