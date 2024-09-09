vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.g.paths = {
	goplsBazelDriver = vim.fn.expand'$HOME/.local/bin/bazel_gopackagesdriver.sh',
}

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.diagnostic.config {
	update_in_insert = true,
}

-- Diagnostics
vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, { desc = '[S]how [D]iagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev [D]iagnostic'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Prev [D]iagnostic'})

