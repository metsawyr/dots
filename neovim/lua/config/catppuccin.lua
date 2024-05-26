require('catppuccin').setup {
	flavour = "macchiato",
	transparent_background = true,
	no_italic = true,

	integrations = {
		cmp = true,
		treesitter = true,
		telescope = true,
		harpoon = true,
		native_lsp = {
			enabled = true,
			virtual_text = {},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
			inlay_hints = {
				background = true,
			},
		},
	}
}

vim.cmd.colorscheme "catppuccin"
