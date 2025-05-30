# home/mel/conf/ui/hyprland/default.nix
{ config, lib, pkgs, colors, ... }:

let
  # Updated wallpaper path to your actual walls directory
  wall = "~/nixos-config/home/images/walls/${colors.name or "default"}.jpg";
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
      env = XCURSOR_THEME,phinger-cursors
      env = XCURSOR_SIZE,24

      
      monitor=,preferred,auto,1 
      # monitor=HDMI-A-1, 1920x1080, 0x0, 1
       monitor=eDP-1, 1920x1080, 1920x0, 1
      
      # Input configuration
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
      
      # General window management - reduced gaps for more compact layout
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
      
      # Dwindle layout settings
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
      
      # Master layout settings
      master {
        new_is_master = true
        special_scale_factor = 0.85
        no_gaps_when_only = true
        mfact = 0.55
        orientation = left
        inherit_fullscreen = true
        always_center_master = false
      }
      
      # Visual effects
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
      
      # Basic window management bindings
      bind = $mainMod, Return, exec, kitty
      bind = $mainMod, Q, exec, grim -g "$(slurp)" ~/Pictures/screenshot.png
      bind = $mainMod SHIFT, Return, exec, kitty --class termfloat
      bind = $mainMod SHIFT, C, killactive,
      bind = $mainMod SHIFT, Q, exit,
      bind = $mainMod SHIFT, Space, togglefloating,
      bind = $mainMod, F, fullscreen, 1
      bind = $mainMod SHIFT, F, fullscreen, 0
      bind = $mainMod, Y, pin
      bind = $mainMod, P, pseudo,
      bind = $mainMod, J, togglesplit,
      bind = $mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      
      # Toggle grouped layout
      bind = $mainMod, K, togglegroup,
      bind = $mainMod, Tab, changegroupactive, f
      bind = $mainMod SHIFT, Tab, changegroupactive, b
      
      # Change gaps dynamically
      bind = $mainMod SHIFT, G, exec, hyprctl --batch "keyword general:gaps_out 12;keyword general:gaps_in 8"
      bind = $mainMod, G, exec, hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"
      bind = $mainMod CTRL, G, exec, hyprctl --batch "keyword general:gaps_out 20;keyword general:gaps_in 15"
      
      # Move focus with arrow keys and vim-like keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d
      
      # Switch workspaces
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
      bind = $mainMod, L, workspace, +1
      bind = $mainMod, H, workspace, -1
      bind = $mainMod, period, workspace, e+1
      bind = $mainMod, comma, workspace, e-1
      
      # Special workspaces (named)
      bind = $mainMod, Q, workspace, name:QQ
      bind = $mainMod, T, workspace, name:TG
      bind = $mainMod, M, workspace, name:Music
      bind = $mainMod, C, workspace, name:Code
      bind = $mainMod, B, workspace, name:Browser
      
      # Special workspace (scratchpad)
      bind = $mainMod, minus, movetoworkspace, special
      bind = $mainMod, equal, togglespecialworkspace
      
      # Move window in current workspace
      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d
      bind = $mainMod SHIFT, h, movewindow, l
      bind = $mainMod SHIFT, l, movewindow, r
      bind = $mainMod SHIFT, k, movewindow, u
      bind = $mainMod SHIFT, j, movewindow, d
      
      # Move active window to workspace
      bind = $mainMod CTRL, 1, movetoworkspace, 1
      bind = $mainMod CTRL, 2, movetoworkspace, 2
      bind = $mainMod CTRL, 3, movetoworkspace, 3
      bind = $mainMod CTRL, 4, movetoworkspace, 4
      bind = $mainMod CTRL, 5, movetoworkspace, 5
      bind = $mainMod CTRL, 6, movetoworkspace, 6
      bind = $mainMod CTRL, 7, movetoworkspace, 7
      bind = $mainMod CTRL, 8, movetoworkspace, 8
      bind = $mainMod CTRL, 9, movetoworkspace, 9
      bind = $mainMod CTRL, 0, movetoworkspace, 10
      bind = $mainMod CTRL, left, movetoworkspace, -1
      bind = $mainMod CTRL, right, movetoworkspace, +1
      bind = $mainMod CTRL, h, movetoworkspace, -1
      bind = $mainMod CTRL, l, movetoworkspace, +1
      
      # Move to workspace silently
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      
      # Scroll through workspaces with mouse
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # Workspace back and forth
      binds {
        workspace_back_and_forth = 1 
        allow_workspace_cycles = 1
      }
      bind = $mainMod, slash, workspace, previous
      
      # Launch applications
      bind = $mainMod, A, exec, rofi -show drun
      bind = $mainMod, R, exec, rofi -show run
      bind = $mainMod, W, exec, rofi -show window
      bind = $mainMod, E, exec, nemo
      bind = $mainMod SHIFT, E, exec, kitty -e ranger
      
      # Volume, brightness, media controls
      bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous
      
      # System controls
      bind = $mainMod SHIFT, R, exec, hyprctl reload
      bind = $mainMod, Escape, exec, wlogout
      bind = $mainMod SHIFT, L, exec, loginctl lock-session
      exec-once = hyprctl setcursor phinger-cursors 24

      
      # Waybar toggle
      bind = $mainMod, O, exec, killall -SIGUSR1 .waybar-wrapped
      
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
      
      # Direct resize bindings
      bind = CTRL SHIFT, left, resizeactive, -20 0
      bind = CTRL SHIFT, right, resizeactive, 20 0
      bind = CTRL SHIFT, up, resizeactive, 0 -20
      bind = CTRL SHIFT, down, resizeactive, 0 20
      bind = CTRL SHIFT, h, resizeactive, -20 0
      bind = CTRL SHIFT, l, resizeactive, 20 0
      bind = CTRL SHIFT, k, resizeactive, 0 -20
      bind = CTRL SHIFT, j, resizeactive, 0 20
      
      # Mouse bindings
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      
      # Startup commands
      exec-once = swww init
      exec = swww img ${wall}
      exec-once = waybar
      exec-once = dunst
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
      
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
