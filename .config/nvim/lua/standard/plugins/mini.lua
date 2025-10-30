return {
	{
		'nvim-mini/mini.nvim',
		config = function()
			---bufferline
			---currently using akinsho/bufferline
			-- require('mini.tabline').setup()

			--- Better text objects
			--- Allows for some really powerful motions
			--- ci' : Change inner '
			require('mini.ai').setup { n_lines = 500 }

			--- Statusline
			require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
		end,
	},
}
