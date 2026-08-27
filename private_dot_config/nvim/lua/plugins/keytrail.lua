return {
	"jfryy/keytrail.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("keytrail").setup()
	end,
}
