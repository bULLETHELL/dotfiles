-- Install plugins here
require('lazy').setup {
	{ 'NMAC427/guess-indent.nvim', opts = {} }, -- detect indents automatically

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
	require 'standard.plugins.lspconfig',
	require 'standard.plugins.blink-cmp',
	require 'standard.plugins.autopairs',
	require 'standard.plugins.conform',
	require 'standard.plugins.bufferline',
	require 'standard.plugins.snacks',
	require 'standard.plugins.mini',
}
