require('lualine').setup {
	options = {
		theme = 'catppuccin'
	},
	sections = {
		lualine_c = {
			{ 'filename', path = 1 },
		},
	},
}
