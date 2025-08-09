return {
	"vimichael/floatingtodo.nvim",
	enabled = false,
	config = function()
		require("floatingtodo").setup({
			target_file = "~/git/wiki/todo.md",
			border = "single", -- single, rounded, etc.
			width = 0.8, -- width of window in % of screen size
			height = 0.8, -- height of window in % of screen size
			position = "center", -- topleft, topright, bottomleft, bottomright
		})
	end,
	keys = {
		{ "<leader>td", "<cmd>Td<cr>", desc = "Floating todo list" },
	},
}
