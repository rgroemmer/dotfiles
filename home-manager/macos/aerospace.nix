{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.roles.work {
    home.file.".config/aerospace/aerospace.toml".text = ''
      ## Options
      start-at-login = true
      enable-normalization-flatten-containers = true

      # Mouse follow focus
      on-focused-monitor-changed = ['move-mouse monitor-lazy-center']


      ## Bindings
      [mode.main.binding]
      ctrl-enter = 'exec-and-forget ${pkgs.alacritty}/bin/alacritty msg create-window || open -n ~/Applications/Home\ Manager\ Apps/Alacritty.app'

      # Movement
      ctrl-f = 'fullscreen'
      ctrl-h = 'focus left'
      ctrl-j = 'focus down'
      ctrl-k = 'focus up'
      ctrl-l = 'focus right'

      # Window placement
      ctrl-shift-h = 'move left'
      ctrl-shift-j = 'move down'
      ctrl-shift-k = 'move up'
      ctrl-shift-l = 'move right'

      ctrl-shift-z = 'join-with left'

      # Workspace selection
      ctrl-1 = 'workspace 1'
      ctrl-2 = 'workspace 2'
      ctrl-3 = 'workspace 3'
      ctrl-4 = 'workspace 4'
      ctrl-5 = 'workspace 5'
      ctrl-6 = 'workspace 6'
      ctrl-7 = 'workspace 7'
      ctrl-8 = 'workspace 8'
      ctrl-9 = 'workspace 9'
      ctrl-0 = 'workspace 10'

      # Layout
      ctrl-shift-o = 'layout floating tiling' # 'floating toggle' in i3
      # Resize
      ctrl-shift-r = 'mode resize'

      # Monitor sequence number from left to right. 1-based indexing
      [workspace-to-monitor-force-assignment]
      1 = 2
      2 = 2
      3 = 2
      4 = 1
      5 = 1
      6 = 3
      7 = 3
      8 = 3
      9 = 3

      [mode.resize.binding]
      h = 'resize width -50'
      j = 'resize height +50'
      k = 'resize height -50'
      l = 'resize width +50'
      enter = 'mode main'
      esc = 'mode main'

      ##-- Window rules / pinning

      # Floating
      [[on-window-detected]]
      if.app-id = 'com.googlecode.iterm2'
      run = ['layout floating']

      # Main display
      [[on-window-detected]]
      if.app-id = 'org.alacritty'
      run = ['move-node-to-workspace 1']

      [[on-window-detected]]
      if.app-id = 'com.microsoft.VSCode'
      run = ['move-node-to-workspace 1']

      # Left display
      [[on-window-detected]]
      if.app-id = 'org.mozilla.firefoxdeveloperedition'
      run = ['move-node-to-workspace 4']
      [[on-window-detected]]
      if.app-id = 'app.zen-browser.zen'
      run = ['move-node-to-workspace 4']

      [[on-window-detected]]
      if.app-id = 'com.microsoft.Outlook'
      run = ['move-node-to-workspace 5']

      # Right display
      [[on-window-detected]]
      if.app-id = 'chat.rocket'
      run = ['move-node-to-workspace 6']
      [[on-window-detected]]
      if.app-id = 'com.microsoft.teams2'
      run = ['move-node-to-workspace 6']
      [[on-window-detected]]
      if.app-id = 'org.keepassxc.keepassxc'
      run = ['layout tiling', 'move-node-to-workspace 7']
      [[on-window-detected]]
      if.app-id = 'mumble-client'
      run = ['layout tiling','move-node-to-workspace 7']
      [[on-window-detected]]
      if.app-id = 'com.initex.proxifier.v3.macos'
      run = ['move-node-to-workspace 8']
      [[on-window-detected]]
      if.app-id = 'com.apple.systempreferences'
      run = ['move-node-to-workspace 9']
    '';
  };
}
