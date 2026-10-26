-- ONE KEY TO RULE THEM ALL
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.cursorline = false
vim.opt.termguicolors = true

-- Behaviour
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.inccommand = 'split'
vim.opt.undofile = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- External
vim.g.have_nerd_font = true

-- Other
vim.opt.mouse = 'a'
vim.opt.updatetime = 250
vim.opt.isfname:append '@-@'
