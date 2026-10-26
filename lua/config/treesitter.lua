vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } }

local parsers = {
  'c',
  'cpp',
  'c_sharp',
  'bash',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'rust',
  'go'
}
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  if not vim.treesitter.language.add(language) then return end

  vim.treesitter.start(buf, language)

  if vim.treesitter.query.get(language, 'indents') ~= nil then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

-- Filetypes and parser names differ (cs -> c_sharp), so resolve the parser per buffer
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local language = vim.treesitter.language.get_lang(args.match)
    if not language then return end

    treesitter_try_attach(args.buf, language)
  end,
})
