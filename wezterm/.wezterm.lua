-- Import wezterm module
local wezterm = require("wezterm")

return {
	-- colorscheme
	color_scheme = "Gruvbox dark, hard (base16)",

	-- window
	initial_rows = 40, -- Optional: you can also set these based on your preference
	initial_cols = 100, -- Optional
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 }, -- Optional padding

	-- Set Git Bash as the default shell
	default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe" },

	-- Define leader key
	leader = { key = "w", mods = "ALT", timeout_milliseconds = 1000 },

	keys = {
		-- Split horizontally with Alt+w+s
		{ key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

		-- Split vertically with Alt+w+v
		{ key = "s", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- Close current pane with Alt+w+q
		{ key = "q", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		-- Navigate panes with LEADER modifier
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") }, -- Move left
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") }, -- Move right
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") }, -- Move up
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },

		-- Create a new tab with Alt+w+n
		{ key = "n", mods = "LEADER", action = wezterm.action.SpawnTab("DefaultDomain") },

		-- Rename a tab
		{
			key = "r",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = "Enter new tab name",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},

		-- Switch between windows using Alt+w+1, Alt+w+2, etc.
		{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
		{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
		{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
		{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
		{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
		{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
		{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
		{ key = "0", mods = "LEADER", action = wezterm.action.ActivateTab(9) },
	},
}

