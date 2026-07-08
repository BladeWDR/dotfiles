return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				noice = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
		vim.cmd.hi("Comment gui=none")
	end,
}
