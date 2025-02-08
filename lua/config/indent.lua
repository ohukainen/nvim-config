return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},

  config = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        if vim.bo.filetype ~= "python" then
          require("ibl").setup({ enabled = false})
        else
          require("ibl").setup({ enabled = true})
        end
      end,
    })
  end,
}

