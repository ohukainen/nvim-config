-- Centered movement
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Copy/Paste/Delete 
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- Move highlighted
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Search and/or Replace
vim.keymap.set('n', '*', '*N')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- Diagnostics
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) vim.cmd('normal! zz') end, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count =  1, severity = vim.diagnostic.severity.ERROR }) vim.cmd('normal! zz') end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>h', function() if not vim.diagnostic.is_enabled({ bufnr = 0 }) then vim.diagnostic.enable(true, { bufnr = 0 }) end vim.diagnostic.show() end)
vim.keymap.set('n', '<leader>b', function() vim.diagnostic.hide() end)

-- Quickfixlist
vim.keymap.set('n', '<leader>k', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>cnext<CR>zz')

-- Window navigation
vim.keymap.set('n', '<C-h>', function() vim.cmd.wincmd('h') end)
vim.keymap.set('n', '<C-j>', function() vim.cmd.wincmd('j') end)
vim.keymap.set('n', '<C-k>', function() vim.cmd.wincmd('k') end)
vim.keymap.set('n', '<C-l>', function() vim.cmd.wincmd('l') end)

-- Window resizing: grow the current window in that direction, shrink when nothing is there
local function resize_towards(direction)
  local vertical = direction == 'h' or direction == 'l'
  local step = (vertical and 5 or 3) * vim.v.count1
  local has_neighbour = vim.fn.winnr(direction) ~= vim.fn.winnr()
  vim.cmd((vertical and 'vertical resize ' or 'resize ') .. (has_neighbour and '+' or '-') .. step)
end

for _, direction in ipairs { 'h', 'j', 'k', 'l' } do
  vim.keymap.set('n', '<C-w><C-' .. direction .. '>', function() resize_towards(direction) end)
end

-- Other
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>ko')
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('c', '!!', 'term ')
