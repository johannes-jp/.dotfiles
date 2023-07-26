local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})--fg = 'find file'
vim.keymap.set('n', '<leader>fg', builtin.git_files, {}) --fg = 'find git'
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {}) --fw = 'find word'

--vim.keymap.set('n', '<leader>fw', function()
    --    builtin.grep_string({ search = vim.fn.input("Grep > ") })
    --end)

return {
    tag = '0.1.2', -- or branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
