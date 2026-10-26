vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/j-hui/fidget.nvim',
}
require('fidget').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode, opts)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, vim.tbl_extend('force', { buffer = event.buf, desc = 'LSP: ' .. desc }, opts or {}))
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    -- nowait: the built-in grr/grn/gra/gri/grt maps would otherwise delay gr by timeoutlen
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences', 'n', { nowait = true })
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

---@type table<string, vim.lsp.Config>
local servers = {
  -- C/C++
  clangd = {},

  -- Rust
  rust_analyzer = {},

  -- Go
  gopls = {},

  -- C#
  roslyn_ls = {
    settings = {
      ['csharp|background_analysis'] = {
        dotnet_analyzer_diagnostics_scope = 'openFiles',
        dotnet_compiler_diagnostics_scope = 'openFiles',
      },
    },
  },

  -- Lua
  stylua = {},
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Formatting is done by stylua

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
      })
    end,
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        format = { enable = false },
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

require('mason').setup {}
require('mason-lspconfig').setup { automatic_enable = false }
require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
