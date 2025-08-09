return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"ribru17/blink-cmp-spell",
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		-- use a release tag to download pre-built binaries
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = "luasnip" },
			keymap = {
				preset = "default",
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				-- show with a list of providers
				["<C-space>"] = {
					function(cmp)
						cmp.show({ providers = { "snippets" } })
					end,
				},
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = { auto_show = false },
				menu = {
					draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } } },
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "snippets", "path", "buffer", "spell" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					spell = {
						name = "Spell",
						module = "blink-cmp-spell",
						opts = {
							-- EXAMPLE: Only enable source in `@spell` captures, and disable it
							-- in `@nospell` captures.
							enable_in_context = function()
								local curpos = vim.api.nvim_win_get_cursor(0)
								local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
								local in_spell_capture = false
								for _, cap in ipairs(captures) do
									if cap.capture == "spell" then
										in_spell_capture = true
									elseif cap.capture == "nospell" then
										return false
									end
								end
								return in_spell_capture
							end,
						},
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = {
				sorts = {
					function(a, b)
						local sort = require("blink.cmp.fuzzy.sort")
						if a.source_id == "spell" and b.source_id == "spell" then
							return sort.label(a, b)
						end
					end,
					-- This is the normal default order, which we fall back to
					"score",
					"kind",
					"label",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		config = function()
			local ls = require("luasnip")
			ls.config.set_config({
				store_selection_keys = "<C-S>",
				update_events = "TextChanged,TextChangedI",
			})

			-- 			local code_snippet_dir = "~/.config/nvim/snippets"
			if vim.fn.isdirectory(code_snippet_dir) then
				require("luasnip.loaders.from_vscode").lazy_load({ paths = code_snippet_dir })
			end
			require("luasnip.loaders.from_vscode").lazy_load()
			--
			-- 			local snippets = {
			-- 				python = vim.tbl_values(require("me.plugins.completion.snippets.python")),
			-- 				markdown = vim.tbl_values(require("me.plugins.completion.snippets.markdown")),
			-- 				lua = vim.tbl_values(require("me.plugins.completion.snippets.lua_snips")),
			-- 			}
			--
			-- 			for file_type, snip in pairs(snippets) do
			-- 				ls.add_snippets(file_type, snip)
			-- 			end
			-- 			require("me.plugins.completion.snippets.go_err")
		end,
	},
}
