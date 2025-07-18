local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Startlocation
config.default_cwd = "C://Entwicklung"

-- Change Frontend -> OpenGL had graphics artefacts when not full screen
config.front_end = "WebGpu"

-- Set leader key to Ctrl+a, like tmux
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Keybindings to mimic tmux
config.keys = {
	-- Scrolling
	{ key = "PageUp", action = act.ScrollByPage(-1) },
	{ key = "PageDown", action = act.ScrollByPage(1) },

	-- Searching
	{ key = "f", mods = "CTRL", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },

	-- Pane splitting
	{ key = "_", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Ctrl+a | for vertical split
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- Ctrl+a - for horizontal split

	-- Pane navigation
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") }, -- Ctrl+a h
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") }, -- Ctrl+a j
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") }, -- Ctrl+a k
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") }, -- Ctrl+a l
	{ key = "q", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Pane resizing
	{ key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) }, -- Ctrl+a H
	{ key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) }, -- Ctrl+a J
	{ key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) }, -- Ctrl+a K
	{ key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) }, -- Ctrl+a L

	-- Tab management
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") }, -- Ctrl+a c for new tab
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) }, -- Ctrl+a n for next tab
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) }, -- Ctrl+a p for previous tab
	{ key = "Q", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) }, -- Ctrl+a & to close tab

	-- Workspace (tmux session) switching
	{ key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) }, -- Ctrl+a s to list workspaces
	{
		key = "w",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter name for new workspace",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
							spawn = {
								cwd = config.default_cwd,
							},
						}),
						pane
					)
				end
			end),
		}),
	}, -- Ctrl+a W to create/switch workspace
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.Multiple({
			wezterm.action.SendString(
				'for /f "delims=" %d in (\'fd -t d -H -E Windows --absolute-path ^| fzf\') do cd /d "%d" && nvim .'
			),
			wezterm.action.SendKey({ key = "Enter" }),
		}),
	},
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action.Multiple({
			wezterm.action.SendString(
				'for /f "delims=" %d in (\'fd -t f -H -E Windows --absolute-path ^| fzf\') do cd /d "%~dpd" && nvim "%d"'
			),
			wezterm.action.SendKey({ key = "Enter" }),
		}),
	},
}

-- Basic visual settings to match tmux aesthetics
config.font_size = 14
config.window_decorations = "TITLE | RESIZE"
config.color_scheme = "Gruvbox Dark"

-- Tab Bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

return config
