return {
	{
		'akinsho/bufferline.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				diagnostics = 'nvim-lsp',
				offsets = {
					{
						--- File type for snacks explorer
						filetype = 'snacks_layout_box',
						text = '',
						text_align = 'center',
						separator = true,
					},
				},
			},
		},
	},
}
