.
├── configuration.nix
├── flake.lock
├── flake.nix
├── hardware-configuration.nix
├── home
│   ├── images
│   │   └── misc
│   │       ├── neofetch.jpg
│   │       └── neofetch.png
│   ├── mel
│   │   ├── conf
│   │   │   ├── shell
│   │   │   │   ├── tmux
│   │   │   │   │   └── default.nix
│   │   │   │   ├── yazi
│   │   │   │   │   ├── keymap.toml
│   │   │   │   │   ├── theme.toml
│   │   │   │   │   ├── yazi.nix
│   │   │   │   │   └── yazi.toml
│   │   │   │   └── zsh
│   │   │   │       ├── aliases.nix
│   │   │   │       ├── default.nix
│   │   │   │       └── starship.nix
│   │   │   ├── term
│   │   │   │   ├── ghostty.nix
│   │   │   │   └── kitty.nix
│   │   │   ├── utils
│   │   │   │   └── vscodium
│   │   │   │       └── default.nix
│   │   │   ├── web
│   │   │   │   ├── brave.nix
│   │   │   │   ├── firefox.nix
│   │   │   │   ├── qutebrowser.nix
│   │   │   │   └── vesktop.nix
│   │   │   └── wm
│   │   │       ├── dunst
│   │   │       │   └── default.nix
│   │   │       ├── hyprland
│   │   │       │   └── default.nix
│   │   │       ├── pywal
│   │   │       │   ├── default.nix
│   │   │       │   └── themes
│   │   │       │       └── waybar.css
│   │   │       ├── rofi
│   │   │       │   └── default.nix
│   │   │       └── waybar
│   │   │           ├── default.nix
│   │   │           ├── scripts
│   │   │           │   ├── colorpicker.sh
│   │   │           │   ├── refresh.sh
│   │   │           │   └── select.sh
│   │   │           └── style.css
│   │   ├── home.nix
│   │   └── misc
│   │       └── neofetch.nix
│   └── shared
│       ├── cols
│       │   └── default.nix
│       ├── default.nix
│       └── xresources.nix
├── homelab
│   ├── default.nix
│   ├── networks
│   ├── samba
│   │   └── default.nix
│   └── services
├── modules
│   ├── desktop.nix
│   ├── jellyfin
│   │   ├── main.nix
│   │   ├── notifications.nix
│   │   └── service.nix
│   ├── networking.nix
│   ├── pkgs.nix
│   ├── samba.nix
│   ├── services.nix
│   ├── ssh.nix
│   ├── theming.nix
│   └── unstable.pkgs.nix
├── overlays
│   └── default.nix
