return {
	"obsidian-nvim/obsidian.nvim",
	version = "v3.11.0",
	lazy = true,
	event = {
		-- vim.fn.expand needed here to expand "~".
		-- These events make it so that the obsidian.nvim plugin is only loaded in the vault.
		"BufReadPre "
			.. vim.fn.expand("~")
			.. "/git/wiki/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/git/wiki/**.md",
		"BufReadPre " .. vim.fn.expand("~") .. "/git/work-notes/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/git/work-notes/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		completion = {
			blink = true,
			nvim_cmp = false,
		},
		workspaces = {
			{
				name = "wiki",
				path = "~/git/wiki",
				overrides = {
					notes_subdir = "docs/00 inbox",
					daily_notes = {
						-- Optional, if you keep daily notes in a separate directory.
						folder = "_daily",
						-- Optional, if you want to change the date format for the ID of daily notes.
						date_format = "%Y-%m-%d",
						-- Optional, if you want to change the date format of the default alias of daily notes.
						alias_format = "%Y-%m-%d Daily Note",
						-- Optional, default tags to add to each new daily note created.
						default_tags = { "daily-notes" },
						-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
						template = "daily note nvim.md",
					},
					templates = {
						folder = "_templates",
						date_format = "%Y-%m-%d",
						time_format = "%H:%M",
						-- A map for custom variables, the key should be the variable and the value a function
						substitutions = {},
					},
				},
			},
			{
				name = "work-notes",
				path = "~/git/work-notes",
				overrides = {
					notes_subdir = "docs/00 - inbox",
					daily_notes = {
						-- Optional, if you keep daily notes in a separate directory.
						folder = "_daily",
						-- Optional, if you want to change the date format for the ID of daily notes.
						date_format = "%Y-%m-%d",
						-- Optional, if you want to change the date format of the default alias of daily notes.
						alias_format = "%Y-%m-%d Daily Note",
						-- Optional, default tags to add to each new daily note created.
						default_tags = { "daily-notes" },
						-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
						template = vim.NIL,
					},
				},
			},
			{
				name = "work-notes",
				path = "C:/Users/Scott/git/work-notes",
				overrides = {
					notes_subdir = "00 inbox",
					daily_notes = {
						-- Optional, if you keep daily notes in a separate directory.
						folder = "_daily",
						-- Optional, if you want to change the date format for the ID of daily notes.
						date_format = "%Y-%m-%d",
						-- Optional, if you want to change the date format of the default alias of daily notes.
						alias_format = "%Y-%m-%d Daily Note",
						-- Optional, default tags to add to each new daily note created.
						default_tags = { "daily-notes" },
						-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
						template = vim.NIL,
					},
				},
			},
		},
		ui = {
			enable = false,
		},
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		note_id_func = function(title)
			return title
		end,
	},
}
