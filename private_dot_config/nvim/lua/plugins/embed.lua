return {
	{
		"embed.nvim",
		url = "https://git.bladewdr.xyz/scottb/embed.nvim.git",
		dependencies = { "obsidian-nvim/obsidian.nvim" },
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/git/wiki/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/git/wiki/**.md",
		},
		opts = {},
	},
}
