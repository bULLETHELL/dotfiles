-- Plugin that adds end parentheses, brackets, etc. by matching their starting character
return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	opts = {},
}
