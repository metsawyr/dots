return {
	"neovim/nvim-lspconfig",
	dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require "config/lsp"
	end
}

