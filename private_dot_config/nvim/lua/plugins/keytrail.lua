return {
	"jfryy/keytrail.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("keytrail").setup()
	end,
}
