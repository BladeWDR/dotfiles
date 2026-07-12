return {
	-- Collection of various small independent plugins/modules
	"nvim-mini/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		-- require("mini.surround").setup()

		require("mini.icons").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		local ok, c = pcall(require, "mauve.palette")
		if not ok then
			ok = true
			c = {
				bg = "#1e1e2e", fg = "#cdd6f4", subtext = "#a6adc8", mauve = "#cba6f7",
				sapphire = "#74c7ec", grey = "#45475a", peach = "#fab387",
				red = "#f38ba8", green = "#a6e3a1", lavender = "#b4befe",
			}
		end

		vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = c.bg, bg = c.mauve, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = c.bg, bg = c.sapphire, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = c.bg, bg = c.peach, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = c.bg, bg = c.red, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = c.bg, bg = c.green, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = c.bg, bg = c.lavender, bold = true })
		vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = c.fg, bg = c.grey })
		vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = c.fg, bg = c.grey })
		vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = c.fg, bg = c.grey })
		vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { fg = c.subtext, bg = c.bg })

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}

