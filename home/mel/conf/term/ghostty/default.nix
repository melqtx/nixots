{ pkgs, colors, ... }:
with colors; {
  programs.ghostty = {
    enable = true;
    settings = {
      # Font configuration
      font-family = "Iosevka Nerd Font";
      font-style = "auto";
      font-style-bold = "auto";
      font-style-italic = "auto";
      font-style-bold-italic = "auto";
      font-size = 12;
      font-feature = "-liga"; # disable ligatures equivalent
      
      confirm-close-surface = false;
      
      
      # Mouse and focus
      mouse-hide-while-typing = false;
      focus-follows-mouse = false;
      click-repeat-interval = 500; # 0.5s in milliseconds
      
      # Cursor
      cursor-style = "block";
      cursor-style-blink = false;
      
      # Performance
      # sync-to-monitor not available in Ghostty
      
      # Bell/notifications
      desktop-notifications = false;
      # visual-bell not available in Ghostty
      
      # Colors
      background = colors.background;
      foreground = colors.foreground;
      cursor-color = colors.foreground;
      
      # ANSI colors
      palette = [
        # Black (0, 8)
        "0=#${colors.color0}"
        "8=#${colors.color0}"
        # Red (1, 9)
        "1=#${colors.color1}"
        "9=#${colors.color9}"
        # Green (2, 10)
        "2=#${colors.color2}"
        "10=#${colors.color10}"
        # Yellow (3, 11)
        "3=#${colors.color3}"
        "11=#${colors.color11}"
        # Blue (4, 12)
        "4=#${colors.color4}"
        "12=#${colors.color12}"
        # Magenta (5, 13)
        "5=#${colors.color5}"
        "13=#${colors.color13}"
        # Cyan (6, 14)
        "6=#${colors.color6}"
        "14=#${colors.color14}"
        # White (7, 15)
        "7=#${colors.color7}"
        "15=#${colors.color15}"
      ];
    };
  };
}
