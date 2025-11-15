return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		default = {
			dir_path = "docs/assets/images",
			use_absolute_path = false,
			prompt_for_file_name = false,
		},
	},
	keys = {
		{ "<leader>I", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
	},
}
