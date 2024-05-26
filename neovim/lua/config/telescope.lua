local telescope = require 'telescope'
telescope.setup {}

local telescope_builtins = require 'telescope.builtin'

vim.keymap.set('n', '<leader>ff', telescope_builtins.find_files, { desc = '[F]ind [f]iles' })
vim.keymap.set('n', '<leader>fg', telescope_builtins.live_grep, { desc = '[F]ind [g]rep' })
vim.keymap.set('n', '<leader>/', telescope_builtins.current_buffer_fuzzy_find,
	{ desc = '[/] Fuzzy search in current buffer' })
vim.keymap.set('n', '<leader>fb', telescope_builtins.buffers, { desc = '[F]ind [b]uffers' })
vim.keymap.set('n', '<leader>ft', telescope_builtins.help_tags, { desc = 'Help [t]ags' })
vim.keymap.set('n', '<leader>fd', telescope_builtins.diagnostics, { desc = '[F]ind [d]iagnostics' })
