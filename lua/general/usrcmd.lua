-- NOTE: Launches browser-sync in another process serving the [C]urrent [W]orking [D]irectory
vim.api.nvim_create_user_command('BrowserSync', function()
    local workingDirectory = vim.fn.getcwd()
    local command = 'browser-sync start --server --directory --files "' .. workingDirectory .. '/*"'
    vim.fn.jobstart(command, {detach = true})
end, {})

-- NOTE: For the windows users 
--
-- vim.api.nvim_create_user_command('BrowserSync', function()
--   local workingDirectory = vim.fn.getcwd()
--   local command = 'start /B browser-sync start --server --directory --files ' .. workingDirectory .. '\\*'
-- 
--   vim.fn.jobstart(command, {detach = true})
-- end, {})
