local wezterm = require 'wezterm'
local action = wezterm.action
local wezterm_config_nvim = wezterm.plugin.require 'https://github.com/winter-again/wezterm-config.nvim'

local config = {}

-- Colors

-- Text
local font = wezterm.font 'RobotoMono Nerd Font'
config.font = font

-- Colors
-- config.color_scheme = 'GruvboxDarkHard'
config.colors = {
  tab_bar = {
    background = '#282828',

    active_tab = {
      bg_color = '#d79921',
      fg_color = '#000000',
    },

    inactive_tab = {
      bg_color = '#282828',
      fg_color = '#ffffff',
    },

    new_tab = {
      bg_color = '#282828',
      fg_color = '#ffffff',
    },
  },
}

-- Tab bar settings
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Window settings
config.window_background_opacity = 0.8

config.enable_scroll_bar = false
config.window_padding = {
  --   left = '1cell',
  right = 0,
}

-- Tab bar
config.window_frame = {
  font = font,
  border_left_width = 0,
  border_right_width = 0,
  border_bottom_height = 0,
  border_top_height = 0,
}

-- status of windows and key tables in right status bar
wezterm.on('update-right-status', function(window, pane)
  local active_key_table = window:active_key_table()
  if active_key_table then
    active_key_table = 'TABLE: ' .. active_key_table
  else
    active_key_table = ''
  end

  local active_workspace = window:active_workspace()
  if active_workspace then
    active_workspace = 'WORKSPACE: ' .. active_workspace
  else
    active_workspace = ''
  end

  window:set_right_status(active_key_table .. ' ' .. active_workspace)
end)

-- keybindings
config.keys = {
  -- TABS
  --
  -- Previous tab
  {
    key = 'p',
    mods = 'SUPER',
    action = action.ActivateTabRelative(-1),
  },
  -- Next tab
  {
    key = 'n',
    mods = 'SUPER',
    action = action.ActivateTabRelative(1),
  },
  -- New tab
  {
    key = 'c',
    mods = 'SUPER',
    action = action.SpawnTab 'CurrentPaneDomain',
  },
  -- kill tab
  {
    key = 'x',
    mods = 'SUPER',
    action = action.CloseCurrentTab { confirm = true },
  },
  -- PANES
  --
  -- Maximize pane
  {
    key = 'm',
    mods = 'SUPER',
    action = action.TogglePaneZoomState,
  },
  -- Pane navigation
  {
    key = 'h',
    mods = 'SUPER',
    action = action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'SUPER',
    action = action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'SUPER',
    action = action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'SUPER',
    action = action.ActivatePaneDirection 'Right',
  },
  -- Split pane veritcally (horizontal is vertical for some reason)
  {
    key = 'v',
    mods = 'SUPER',
    action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split pane horizontally (vertical is horizontal for some reason)
  {
    key = 'v',
    mods = 'SUPER|SHIFT',
    action = action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Kill pane
  {
    key = 'q',
    mods = 'SUPER',
    action = action.CloseCurrentPane { confirm = false },
  },
  -- Resize panes
  {
    key = 'r',
    mods = 'SUPER',
    action = action.ActivateKeyTable {
      name = 'resize_pane',
      -- Don't close after first press
      one_shot = false,
    },
  },

  -- WORKSPACES
  --
  {
    -- Prompt for a new workspace name
    key = 'w',
    mods = 'SUPER',
    action = action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            action.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
}

-- Modes / key tables
config.key_tables = {
  -- Resize pane mode
  resize_pane = {
    {
      key = 'h',
      action = action.AdjustPaneSize { 'Left', 1 },
    },
    {
      key = 'j',
      action = action.AdjustPaneSize { 'Down', 1 },
    },
    {
      key = 'k',
      action = action.AdjustPaneSize { 'Up', 1 },
    },
    {
      key = 'l',
      action = action.AdjustPaneSize { 'Right', 1 },
    },
    -- Exit resize pane mode
    {
      key = 'Escape',
      action = 'PopKeyTable',
    },
  },
}

-- nvim stuff
wezterm.on('user-var-changed', function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  overrides = wezterm_config_nvim.override_user_var(overrides, name, value)
  window:set_config_overrides(overrides)
end)

return config
