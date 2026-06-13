require('nvim-treesitter').setup()

require('nvim-treesitter').install {
	"c",
	"c3",
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
}

-- The main branch dropped the module system; highlighting and indentation
-- are now started manually per buffer.
vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		if pcall(vim.treesitter.start) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
