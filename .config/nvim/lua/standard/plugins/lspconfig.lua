-- LSP plugins
return {
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		---@module 'lazydev'
		---@type lazydev.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
				-- Load snacks types
				{ path = 'snacks.nvim',        words = { 'Snacks' } },
			}
		}
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Mason for easy lsp installation
			{
				'mason-org/mason.nvim',
				opts = {},
			},
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			-- Great completions plugin
			'saghen/blink.cmp',
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('standard-lsp-attach', { clear = true }),
				callback = function(event)
					-- Create function for mapping keybindings
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- LSP Rename
					map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')

					-- Code actions
					map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction', { 'n', 'x' })

					-- Goto declarations
					map('gD', function()
						Snacks.picker.lsp_declarations()
					end, '[g]oto [D]eclarations')

					-- Goto definitions
					map('gd', function()
						Snacks.picker.lsp_definitions()
					end, '[g]oto [d]efinitions')

					-- Goto references
					map('gr', function()
						Snacks.picker.lsp_references()
					end, '[g]oto [r]eferences')

					-- Goto implementations
					map('gI', function()
						Snacks.picker.lsp_implementations()
					end, '[g]oto [I]mplementations')

					-- Goto type definitions
					map('gt', function()
						Snacks.picker.lsp_type_definitions()
					end, '[g]oto [t]ype definitions')
				end
			})

			-- Diagnostics
			vim.diagnostic.config {
				serverity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					}
				} or {},
				virtual_text = {
					source = 'if_many',
					spacing = 2,
				},
			}


			-- LSP servers are added here
			local servers = {
				-- Servers installed with mason
				mason = {
					lua_ls = {
						settings = {
							Lua = {
								completion = {
									callSnippet = 'Replace',
								}
							}
						}
					},
				},

				-- not installed by mason
				others = {
				},
			}

			local ensure_installed = vim.tbl_keys(servers.mason or {})
			vim.list_extend(ensure_installed, {
				'stylua', -- Always installed
			})
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			for server, config in pairs(vim.tbl_extend('keep', servers.mason, servers.others)) do
				if not vim.tbl_isempty(config) then
					vim.lsp.config(server, config)
				end
			end

			-- enable the language servers by using mason-lspconfig which automatically calls vim.lsp.enable
			require('mason-lspconfig').setup {
				ensure_installed = {}, -- Already installed with mason-tool-installer
				automatic_enable = true, -- This run vim.lsp.enable on all LSPs installed with mason
			}

			-- Run vim.lsp.enable manually for others
			if not vim.tbl_isempty(servers.others) then
				vim.lsp.enable(vim.tbl_keys(servers.others))
			end
		end
	}
}
