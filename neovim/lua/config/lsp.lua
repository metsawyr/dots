require('neodev').setup()
local lspconfig = require('lspconfig')
local util = lspconfig.util

local search_bazel_workspace = util.root_pattern('WORKSPACE', 'WORKSPACE.bazel', 'MODULE')

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func, desc)
		if desc then
			desc = 'lsp: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	local telescope_builtins = require('telescope.builtin')
	bufmap('K', vim.lsp.buf.hover, 'Hover documentation')

	bufmap('<localleader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	bufmap('<localleader>ca', vim.lsp.buf.code_action, '[C]ode [a]ctions')

	bufmap('<localleader>gi', telescope_builtins.lsp_implementations, '[G]o to [i]mplementations')
	bufmap('<localleader>gd', telescope_builtins.lsp_definitions, '[G]o to [d]efinitions')
	bufmap('<localleader>gt', telescope_builtins.lsp_type_definitions, '[G]o to [t]ype definition')

	bufmap('<localleader>fr', telescope_builtins.lsp_references, '[F]ind [r]eferences')
	bufmap('<localleader>fs', telescope_builtins.lsp_document_symbols, '[F]ind [s]ymbols')
	bufmap('<localleader>ws', telescope_builtins.lsp_dynamic_workspace_symbols, 'Find [w]orkspace [s]ymbols')

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local lsp_configurations = {
	bufls = {},
	nil_ls = {},
	rust_analyzer = {},
	golangci_lint_ls = {},
	gopls = {
		settings = {
			gopls = {
				gofumpt = true,
				["ui.semanticTokens"] = true,
			},
		},
		on_init = function(client)
			local bazel_workspace_path = search_bazel_workspace(client.workspace_folders[1].name)
			if not bazel_workspace_path then
				return true
			end

			local bazel_workspace_name = string.match(bazel_workspace_path, '([^/]+)/?$')
			client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
				gopls = {
					env = {
						GOPACKAGESDRIVER = vim.g.paths.goplsBazelDriver,
					},
					directoryFilters = {
						'-bazel-bin',
						'-bazel-out',
						'-bazel-testlogs',
						'-bazel-' .. bazel_workspace_name,
					},
				}
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
			return true
		end
	},
	lua_ls = {
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
				client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
					Lua = {
						runtime = {
							version = 'LuaJIT'
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME .. "/lua"
							}
						}
					}
				})

				client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
			end

			return true
		end
	},
};

for lsp_name, config_overrides in pairs(lsp_configurations) do
	lspconfig[lsp_name].setup(
		vim.tbl_extend(
			'force',
			{
				on_attach = on_attach,
				capabilities = capabilities,
			},
			config_overrides
		)
	)
end
