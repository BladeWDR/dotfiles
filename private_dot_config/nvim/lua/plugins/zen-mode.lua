return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			options = {
				relativenumber = true,
			},
			width = 0.75,
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
