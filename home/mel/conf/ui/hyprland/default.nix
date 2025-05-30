{ config, lib, pkgs, colors, ... }:

let
  wall = "~/nixos-config/home/images/walls/${colors.name or "default"}.jpg";
  #TODO
  scrPath = "~/.config/hypr/scripts";
in
{
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    
    extraConfig = ''
      env = XCURSOR_THEME,phinger-cursors
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_THEME,phinger-cursors
      env = HYPRCURSOR_SIZE,24
      $mainMod = SUPER
      
      $TERMINAL = kitty
      $EDITOR = code
      $EXPLORER = nemo
      $BROWSER = firefox
      
      monitor=,preferred,auto,1 
      # monitor=HDMI-A-1, 1920x1080, 0x0, 1
      monitor=eDP-1, 1920x1080, 1920x0, 1
      
      input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options = caps:escape
        kb_rules =
        follow_mouse = 1
        float_switch_override_focus = 2
        numlock_by_default = true
        touchpad {
          natural_scroll = yes
          scroll_factor = 0.5
        }
        sensitivity = 0
        accel_profile = adaptive
      }
      
      general {
        gaps_in = 8
        gaps_out = 12
        border_size = 2
        col.active_border = rgb(${colors.accent or "89b4fa"})
        col.inactive_border = rgba(595959aa)
        layout = dwindle
        allow_tearing = false
        resize_on_border = true
        extend_border_grab_area = 15
      }
      
      dwindle {
        no_gaps_when_only = true
        force_split = 0 
        special_scale_factor = 0.85
        split_width_multiplier = 1.0 
        use_active_for_splits = true
        pseudotile = yes 
        preserve_split = yes 
        smart_split = false
        smart_resizing = true
      }
      
      master {
        new_is_master = true
        special_scale_factor = 0.85
        no_gaps_when_only = true
        mfact = 0.55
        orientation = left
        inherit_fullscreen = true
        always_center_master = false
      }
      
      decoration {
        active_opacity = 1.0
        inactive_opacity = 0.95
        fullscreen_opacity = 1.0
        rounding = 8
        
        drop_shadow = true
        shadow_range = 8
        shadow_render_power = 2
        shadow_ignore_window = true
        col.shadow = rgba(1e1e2e80)
        shadow_offset = 2 2
        
        dim_inactive = true
        dim_strength = 0.1
        
        blur {
          enabled = true
          size = 6
          passes = 3
          new_optimizations = true
          xray = false
          ignore_opacity = false
          noise = 0.02
          contrast = 1.0
          brightness = 1.0
          vibrancy = 0.2
          vibrancy_darkness = 0.5
          popups = true
          popups_ignorealpha = 0.6
        }
      }
      
      # Animations - smoother and faster
      animations {
        enabled = true
        first_launch_animation = true
        
        bezier = md3_standard, 0.2, 0, 0, 1
        bezier = md3_decel, 0.05, 0.7, 0.1, 1
        bezier = md3_accel, 0.3, 0, 0.8, 0.15
        bezier = overshot, 0.05, 0.9, 0.1, 1.05
        bezier = crazyshot, 0.1, 1.5, 0.76, 0.92 
        bezier = hyprnostretch, 0.05, 0.9, 0.1, 1.0
        bezier = fluent_decel, 0.1, 1, 0, 1
        bezier = easeOutCirc, 0, 0.55, 0.45, 1
        
        animation = windows, 1, 4, md3_decel, popin 85%
        animation = windowsIn, 1, 4, md3_decel, popin 85%
        animation = windowsOut, 1, 4, md3_accel, popin 85%
        animation = windowsMove, 1, 4, md3_decel, slide
        animation = border, 1, 8, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 4, default
        animation = fadeIn, 1, 4, md3_decel
        animation = fadeOut, 1, 4, md3_accel
        animation = workspaces, 1, 5, easeOutCirc, slide
        animation = specialWorkspace, 1, 4, md3_decel, slidevert
      }
      
      # Gestures
      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
        workspace_swipe_distance = 200
        workspace_swipe_invert = true
        workspace_swipe_min_speed_to_force = 15
        workspace_swipe_cancel_ratio = 0.5
        workspace_swipe_create_new = true
        workspace_swipe_direction_lock = true
        workspace_swipe_direction_lock_threshold = 10
        workspace_swipe_forever = false
      }
      
      # Misc settings
      misc {
        disable_autoreload = false
        disable_hyprland_logo = true
        disable_splash_rendering = true
        always_follow_on_dnd = true
        layers_hog_keyboard_focus = true
        animate_manual_resizes = true
        animate_mouse_windowdragging = true
        enable_swallow = true
        swallow_regex = ^(kitty|Alacritty|foot)$
        swallow_exception_regex = ^(wev)$
        focus_on_activate = true
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
        vfr = true
        vrr = 0
        render_ahead_of_time = false
        render_ahead_safezone = 1
        allow_session_lock_restore = true
        background_color = rgb(11111b)
        close_special_on_empty = true
        new_window_takes_over_fullscreen = 0
      }
      
      # Custom mouse sensitivity
      device:epic mouse V1 {
        sensitivity = -0.5
      }
      
      # ========================================
      # WINDOW MANAGEMENT KEYBINDS
      # ========================================
      
      # Close and kill windows
      bind = $mainMod, Q, killactive
      bind = Alt, F4, killactive
      bind = $mainMod, Delete, exit
      
      # Window state controls
      bind = $mainMod, W, exec, hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact 95% 95%; dispatch centerwindow"
      bind = $mainMod, G, togglegroup
      bind = Shift, F11, fullscreen
      bind = $mainMod, L, exec, loginctl lock-session
      bind = $mainMod SHIFT, F, pin
      bind = Control Alt, Delete, exec, wlogout
      bind = Alt_R, Control_R, exec, killall waybar || waybar
      
      # Group Navigation
      bind = $mainMod Control, H, changegroupactive, b
      bind = $mainMod Control, L, changegroupactive, f
      
      # Focus movement
      bind = $mainMod, Left, movefocus, l
      bind = $mainMod, Right, movefocus, r
      bind = $mainMod, Up, movefocus, u
      bind = $mainMod, Down, movefocus, d
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d
      bind = ALT, Tab, cyclenext
      
      # Resize windows
      binde = $mainMod Shift, Right, resizeactive, 30 0
      binde = $mainMod Shift, Left, resizeactive, -30 0
      binde = $mainMod Shift, Up, resizeactive, 0 -30
      binde = $mainMod Shift, Down, resizeactive, 0 30
      binde = $mainMod Shift, l, resizeactive, 30 0
      binde = $mainMod Shift, h, resizeactive, -30 0
      binde = $mainMod Shift, k, resizeactive, 0 -30
      binde = $mainMod Shift, j, resizeactive, 0 30
      
      # Move windows within workspace
      bind = $mainMod Shift Control, left, movewindow, l
      bind = $mainMod Shift Control, right, movewindow, r
      bind = $mainMod Shift Control, up, movewindow, u
      bind = $mainMod Shift Control, down, movewindow, d
      bind = $mainMod Shift Control, h, movewindow, l
      bind = $mainMod Shift Control, l, movewindow, r
      bind = $mainMod Shift Control, k, movewindow, u
      bind = $mainMod Shift Control, j, movewindow, d
      
      # Mouse bindings for moving/resizing
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      bindm = $mainMod, Z, movewindow
      bindm = $mainMod, X, resizewindow
      
      # Toggle split
      bind = $mainMod, J, togglesplit
      
      # ========================================
      # APPLICATION LAUNCHERS
      # ========================================
      
      # Terminal applications
      bind = $mainMod, T, exec, $TERMINAL
      bind = $mainMod Alt, T, exec, [float; move 20% 5%; size 60% 60%] $TERMINAL
      bind = $mainMod, Return, exec, $TERMINAL
      bind = $mainMod SHIFT, Return, exec, $TERMINAL --class termfloat
      
      # Core applications
      bind = $mainMod, E, exec, $EXPLORER
      bind = $mainMod, C, exec, $EDITOR
      bind = $mainMod, B, exec, $BROWSER
      bind = Control Shift, Escape, exec, htop
      
      # Rofi menus
      bind = $mainMod, A, exec, rofi -show drun
      bind = $mainMod, TAB, exec, rofi -show window
      bind = $mainMod, R, exec, rofi -show run
      bind = $mainMod Shift, E, exec, rofi -show filebrowser
      bind = $mainMod, slash, exec, rofi -show keys
      bind = $mainMod, comma, exec, rofi -show emoji
      bind = $mainMod, period, exec, rofi -show symbols
      bind = $mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      bind = $mainMod Shift, V, exec, rofi -show clipboard
      bind = $mainMod Shift, A, exec, rofi -show
      
      # ========================================
      # HARDWARE CONTROLS
      # ========================================
      
      # Audio controls
      bind = , F10, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      binde = , F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      binde = , F12, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      binde = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      binde = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      
      # Media controls
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioPause, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous
      
      # Brightness controls
      binde = , XF86MonBrightnessUp, exec, brightnessctl set +5%
      binde = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
      
      # ========================================
      # UTILITIES
      # ========================================
      
      # Keyboard layout toggle (if you need it)
      bind = $mainMod, K, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next
      
      # Screen capture
      bind = $mainMod Shift, P, exec, hyprpicker -an
      bind = $mainMod, P, exec, grim -g "$(slurp)" ~/Pictures/screenshot.png
      bind = $mainMod Control, P, exec, grim -g "$(slurp)" - | wl-copy
      bind = $mainMod Alt, P, exec, grim ~/Pictures/screenshot.png
      bind = , Print, exec, grim ~/Pictures/screenshot.png
      
      # ========================================
      # THEMING AND WALLPAPER 
      # ========================================
      
      # Gap controls
      bind = $mainMod SHIFT, G, exec, hyprctl --batch "keyword general:gaps_out 12;keyword general:gaps_in 8"
      bind = $mainMod, G, exec, hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"
      bind = $mainMod CTRL, G, exec, hyprctl --batch "keyword general:gaps_out 20;keyword general:gaps_in 15"
      
      # System controls
      bind = $mainMod SHIFT, R, exec, hyprctl reload
      bind = $mainMod, Escape, exec, wlogout
      
      # ========================================
      # WORKSPACE MANAGEMENT
      # ========================================
      
      # Navigate to workspaces
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      
      # Relative workspace navigation
      bind = $mainMod Control, Right, workspace, r+1
      bind = $mainMod Control, Left, workspace, r-1
      bind = $mainMod Control, l, workspace, r+1
      bind = $mainMod Control, h, workspace, r-1
      bind = $mainMod, period, workspace, e+1
      bind = $mainMod, comma, workspace, e-1
      
      # Navigate to empty workspace
      bind = $mainMod Control, Down, workspace, empty
      
      # Move window to workspace
      bind = $mainMod Shift, 1, movetoworkspace, 1
      bind = $mainMod Shift, 2, movetoworkspace, 2
      bind = $mainMod Shift, 3, movetoworkspace, 3
      bind = $mainMod Shift, 4, movetoworkspace, 4
      bind = $mainMod Shift, 5, movetoworkspace, 5
      bind = $mainMod Shift, 6, movetoworkspace, 6
      bind = $mainMod Shift, 7, movetoworkspace, 7
      bind = $mainMod Shift, 8, movetoworkspace, 8
      bind = $mainMod Shift, 9, movetoworkspace, 9
      bind = $mainMod Shift, 0, movetoworkspace, 10
      
      # Move window to relative workspace
      bind = $mainMod Control+Alt, Right, movetoworkspace, r+1
      bind = $mainMod Control+Alt, Left, movetoworkspace, r-1
      bind = $mainMod Control+Alt, l, movetoworkspace, r+1
      bind = $mainMod Control+Alt, h, movetoworkspace, r-1
      
      # Scroll through workspaces with mouse
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # Special workspaces (scratchpad)
      bind = $mainMod Shift, S, movetoworkspace, special
      bind = $mainMod Alt, S, movetoworkspacesilent, special
      bind = $mainMod, S, togglespecialworkspace
      bind = $mainMod, minus, movetoworkspace, special
      bind = $mainMod, equal, togglespecialworkspace
      
      # Move to workspace silently
      bind = $mainMod Alt, 1, movetoworkspacesilent, 1
      bind = $mainMod Alt, 2, movetoworkspacesilent, 2
      bind = $mainMod Alt, 3, movetoworkspacesilent, 3
      bind = $mainMod Alt, 4, movetoworkspacesilent, 4
      bind = $mainMod Alt, 5, movetoworkspacesilent, 5
      bind = $mainMod Alt, 6, movetoworkspacesilent, 6
      bind = $mainMod Alt, 7, movetoworkspacesilent, 7
      bind = $mainMod Alt, 8, movetoworkspacesilent, 8
      bind = $mainMod Alt, 9, movetoworkspacesilent, 9
      bind = $mainMod Alt, 0, movetoworkspacesilent, 10
      
      # Named workspaces
      bind = $mainMod, M, workspace, name:Music
      bind = $mainMod Shift, M, movetoworkspace, name:Music
      
      # Workspace back and forth
      binds {
        workspace_back_and_forth = 1 
        allow_workspace_cycles = 1
      }
      bind = $mainMod, grave, workspace, previous
      
      # Resize window mode
      bind = ALT, R, submap, resize
      submap = resize
      binde = , right, resizeactive, 20 0
      binde = , left, resizeactive, -20 0
      binde = , up, resizeactive, 0 -20
      binde = , down, resizeactive, 0 20
      binde = , l, resizeactive, 20 0
      binde = , h, resizeactive, -20 0
      binde = , k, resizeactive, 0 -20
      binde = , j, resizeactive, 0 20
      bind = , escape, submap, reset 
      bind = , return, submap, reset
      submap = reset
      
      # Waybar toggle
      bind = $mainMod, O, exec, killall -SIGUSR1 .waybar-wrapped
      
      # Startup commands
      exec-once = swww init
      exec = swww img ${wall}
      exec-once = waybar
      exec-once = dunst
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
      exec-once = hyprctl setcursor phinger-cursors 24
      
      # Window rules
      windowrule = float, title:^(Picture-in-Picture)$
      windowrule = size 960 540, title:^(Picture-in-Picture)$
      windowrule = move 25%-, title:^(Picture-in-Picture)$
      windowrule = pin, title:^(Picture-in-Picture)$
      
      windowrule = float, imv
      windowrule = move 25%-, imv
      windowrule = size 960 540, imv
      
      windowrule = float, mpv
      windowrule = move 25%-, mpv
      windowrule = size 960 540, mpv
      windowrule = pin, mpv
      
      windowrule = float, termfloat
      windowrule = move 25%-, termfloat
      windowrule = size 960 540, termfloat
      windowrule = rounding 12, termfloat
      
      windowrule = float, nemo
      windowrule = move 25%-, nemo
      windowrule = size 1200 800, nemo
      
      windowrule = opacity 0.95, title:Telegram
      windowrule = opacity 0.95, title:Discord
      windowrule = opacity 0.98, ^(code-oss)$
      windowrule = opacity 0.98, ^(firefox)$
      
      windowrule = workspace name:TG, title:Telegram
      windowrule = workspace name:Music, title:Spotify
      windowrule = workspace name:Code, ^(code-oss)$
      windowrule = workspace name:Browser, ^(firefox)$
      windowrule = workspace name:QQ, ^(qqmusic)$
      
      # Disable blur for better performance
      windowrule = noblur, ^(firefox)$
      windowrule = noblur, ^(waybar)$
      windowrule = noblur, class:^(steam)$
      
      # Fix for some applications
      windowrule = noinitialfocus, ^(steam)$
      windowrule = stayfocused, ^(pinentry-)
      windowrule = float, ^(pavucontrol)$
      windowrule = float, ^(blueman-manager)$
      windowrule = float, ^(nm-connection-editor)$
      windowrule = float, ^(file-roller)$
      
      # Gaming optimizations
      windowrule = immediate, ^(steam_app).*
      windowrule = fullscreen, ^(steam_app).*
      windowrule = workspace name:Games, ^(steam_app).*
    '';
  };
}
