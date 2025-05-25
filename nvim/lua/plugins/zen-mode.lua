return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			options = {
				relativenumber = true,
			},
		},
		plugins = {
			tmux = {
				enabled = true,
			},
			gitsigns = {
				enabled = false,
			},
			twilight = {
				enabled = true,
			},
		},
	},
}
