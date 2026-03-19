return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option(
						"conceallevel",
						{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
					)
					:map("<leader>uc")
				Snacks.toggle
					.option(
						"showtabline",
						{ off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
					)
					:map("<leader>uA")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.dim():map("<leader>uD")
				Snacks.toggle.animate():map("<leader>ua")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.scroll():map("<leader>uS")
				Snacks.toggle.profiler():map("<leader>dpp")
				Snacks.toggle.profiler_highlights():map("<leader>dph")
				if vim.lsp.inlay_hint then
					Snacks.toggle.inlay_hints():map("<leader>uh")
				end
			end,
		})
	end,
}
