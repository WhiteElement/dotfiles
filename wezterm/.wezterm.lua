-- Import wezterm module
local wezterm = require("wezterm")

return {

	color_scheme = "Catppuccin Macchiato",
	-- font = wezterm.font("JetBrains Mono NL"),
	font_size = 16,

	-- Define leader key
	leader = { key = "w", mods = "ALT", timeout_milliseconds = 1000 },

	keys = {
		{ key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		{ key = "q", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") }, -- Move left
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") }, -- Move right
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") }, -- Move up
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },

		{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("DefaultDomain") },

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

		{ key = "w", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
		{ key = "n", mods = "LEADER", action = wezterm.action.SwitchWorkspaceRelative(1) },

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

	-- tab bar
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	tab_and_split_indices_are_zero_based = false,

	-- tmux status
	wezterm.on("update-right-status", function(window, _)
		local SOLID_LEFT_ARROW = ""
		local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
		local prefix = ""

		if window:leader_is_active() then
			prefix = " " .. utf8.char(0x1f30a) -- ocean wave
			SOLID_LEFT_ARROW = utf8.char(0xe0b2)
		end

		if window:active_tab():tab_id() ~= 0 then
			ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
		end -- arrow color based on if tab is first pane

		window:set_left_status(wezterm.format({
			{ Background = { Color = "#b7bdf8" } },
			{ Text = prefix },
			ARROW_FOREGROUND,
			{ Text = SOLID_LEFT_ARROW },
		}))
	end),
}
