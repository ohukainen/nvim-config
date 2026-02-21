return { 
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local filetypes = {
      'c',
      'cpp',
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
    require('nvim-treesitter').install(filetypes)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function() vim.treesitter.start() end,
    })
  end,
}
