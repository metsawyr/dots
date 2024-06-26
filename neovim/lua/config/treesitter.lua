require('nvim-treesitter.configs').setup {
	auto_install = false,
	ensure_installed = {
		"c",
		"cmake",
		"comment",
		"cpp",
		"css",
		"cue",
		"diff",
		"erlang",
		"gitignore",
		"gleam",
		"go",
		"gomod",
		"gosum",
		"gotmpl",
		"gowork",
		"gpg",
		"graphql",
		"groovy",
		"helm",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonnet",
		"lua",
		"make",
		"nix",
		"promql",
		"proto",
		"sql",
		"toml",
		"typescript",
		"tsx",
		"yaml",
	},
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<C-space>',
			node_incremental = '<C-space>',
			node_decremental = '<C-BS>',
			scope_incremental = '<C-s>',
		},
	},
	textobjects = {
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				[']f'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']F'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[f'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[F'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
	},
}
