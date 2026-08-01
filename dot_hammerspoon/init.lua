PaperWM = hs.loadSpoon("PaperWM")

-- ── Niri-like Layout Configuration ─────────────────────────────────────────
PaperWM.window_gap = 8
PaperWM.default_width = 0.5
PaperWM.window_ratios = { 0.33333, 0.5, 0.66667 }

-- ── Window Rules & App Widths ──────────────────────────────────────────────
PaperWM.app_widths = {
	["Firefox"] = 1.0,
	["org.mozilla.firefox"] = 1.0,
}

-- Float Firefox Picture-in-Picture windows
PaperWM.window_filter:setAppFilter("Firefox", { rejectTitles = "Picture-in-Picture" })

-- ── Primary Niri Keybindings (Mod = Alt / Option) ──────────────────────────
local mod = { "alt" }
local mod_shift = { "alt", "shift" }
local mod_ctrl = { "alt", "ctrl" }
local mod_ctrl_shift = { "alt", "ctrl", "shift" }

PaperWM:bindHotkeys({
	-- ── Focus (Vim keys) ──────────────────────────────────────────────────
	focus_left = { mod, "h" },
	focus_down = { mod, "j" },
	focus_up = { mod, "k" },
	focus_right = { mod, "l" },

	-- ── Move Windows ──────────────────────────────────────────────────────
	swap_left = { mod_shift, "h" },
	swap_down = { mod_shift, "j" },
	swap_up = { mod_shift, "k" },
	swap_right = { mod_shift, "l" },

	-- Move column to workspace
	move_window_1 = { mod_shift, "1" },
	move_window_2 = { mod_shift, "2" },
	move_window_3 = { mod_shift, "3" },
	move_window_4 = { mod_shift, "4" },
	move_window_5 = { mod_shift, "5" },
	move_window_6 = { mod_shift, "6" },
	move_window_7 = { mod_shift, "7" },
	move_window_8 = { mod_shift, "8" },
	move_window_9 = { mod_shift, "9" },

	-- Move column to monitor (left / right)
	move_window_l = { mod_ctrl_shift, "h" },
	move_window_r = { mod_ctrl_shift, "l" },

	-- ── Layout & Sizing ───────────────────────────────────────────────────
	full_width = { mod, "f" },
	cycle_width = { mod, "r" },
	cycle_height = { mod_shift, "r" },
	decrease_width = { mod, "-" },
	increase_width = { mod, "=" },
	center_window = { mod, "a" },

	-- Column grouping (Slurp / Barf)
	slurp_in = { mod, "]" },
	barf_out = { mod, "[" },

	-- ── Floating ──────────────────────────────────────────────────────────
	toggle_floating = { mod_shift, "space" },
	-- focus_floating = { mod, "space" },

	-- ── Utility ───────────────────────────────────────────────────────────
	refresh_windows = { mod_ctrl, "r" },
})

-- ── Secondary Niri Binds (Arrow keys & alternates) ────────────────────────
local actions = PaperWM.actions.actions()

-- Arrow key focus & movement fallbacks
hs.hotkey.bind(mod, "left", actions.focus_left)
hs.hotkey.bind(mod, "down", actions.focus_down)
hs.hotkey.bind(mod, "up", actions.focus_up)
hs.hotkey.bind(mod, "right", actions.focus_right)

hs.hotkey.bind(mod_shift, "left", actions.swap_left)
hs.hotkey.bind(mod_shift, "down", actions.swap_down)
hs.hotkey.bind(mod_shift, "up", actions.swap_up)
hs.hotkey.bind(mod_shift, "right", actions.swap_right)

-- Page Up / Page Down workspace focus
hs.hotkey.bind(mod, "pageup", actions.switch_space_l)
hs.hotkey.bind(mod, "pagedown", actions.switch_space_r)

-- Alternate Consume / Expel (Mod+V / Mod+B)
hs.hotkey.bind(mod, "v", actions.slurp_in)
hs.hotkey.bind(mod, "b", actions.barf_out)

-- Alternate Monitor movement (Mod+Ctrl+Shift+Left/Right)
hs.hotkey.bind(mod_ctrl_shift, "left", actions.move_window_l)
hs.hotkey.bind(mod_ctrl_shift, "right", actions.move_window_r)

PaperWM:start()
