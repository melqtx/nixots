{ 
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = import ../../../../shared/cols {};
in

{
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
      highlight = "fg=#928374,bg=none,bold,underline";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "pattern" "cursor" ];
      styles = {
        "default" = "none";
        "unknown-token" = "fg=red,bold";
        "reserved-word" = "fg=yellow";
        "alias" = "fg=green";
        "builtin" = "fg=green";
        "function" = "fg=green";
        "command" = "fg=green";
        "precommand" = "fg=green,underline";
        "commandseparator" = "none";
        "hashed-command" = "fg=green";
        "path" = "underline";
        "path_prefix" = "underline";
        "path_approx" = "fg=yellow,underline";
        "globbing" = "fg=blue";
        "history-expansion" = "fg=blue";
        "single-hyphen-option" = "none";
        "double-hyphen-option" = "none";
        "back-quoted-argument" = "none";
        "single-quoted-argument" = "fg=yellow";
        "double-quoted-argument" = "fg=yellow";
        "dollar-double-quoted-argument" = "fg=cyan";
        "back-double-quoted-argument" = "fg=cyan";
        "assign" = "none";
      };
    };
    enableCompletion = true;
    shellAliases = import ./aliases.nix { inherit config pkgs; };
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      save = 10000;
      size = 10000;
      share = true;
    };
    
    sessionVariables = {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#928374,bg=none,bold,underline";
    };
    
    initContent = ''
      # History options
      setopt EXTENDED_HISTORY
      setopt INC_APPEND_HISTORY
      setopt SHARE_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      
      bindkey "^[[H" beginning-of-line
      bindkey "^[[4~" end-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char
      
      # Path and environment
      export PATH=${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/share/nvim/mason/bin:$PATH
      export COLS=${colors.background}\ ${colors.foreground}\ ${colors.color1}\ ${colors.color2}\ ${colors.color3}\ ${colors.color4}\ ${colors.color5}\ ${colors.color6}\ ${colors.color7}\ ${colors.color8}\ ${colors.color9}\ ${colors.color10}\ ${colors.color11}\ ${colors.color12}\ ${colors.color13}\ ${colors.color14}\ ${colors.color15}\ ${colors.mbg}\ ${colors.color0}\ ${colors.comment}
      export LD_LIBRARY_PATH=${config.home.homeDirectory}/.config/awesome:${pkgs.lua54Packages.lua}/lib/:${pkgs.pam}/lib
      
      
      # Fuzzy directory navigation
      _fuzzy_change_directory() {
          local initial_query="$1"
          local selected_dir
          local fzf_options=('--preview=ls -p {}' '--preview-window=right:60%')
          fzf_options+=(--height "80%" --layout=reverse --preview-window right:60% --cycle)
          local max_depth=7

          if [[ -n "$initial_query" ]]; then
              fzf_options+=("--query=$initial_query")
          fi

          selected_dir=$(find . -maxdepth $max_depth \( -name .git -o -name node_modules -o -name .venv -o -name target -o -name .cache \) -prune -o -type d -print 2>/dev/null | fzf "''${fzf_options[@]}")

          if [[ -n "$selected_dir" && -d "$selected_dir" ]]; then
              cd "$selected_dir" || return 1
          else
              return 1
          fi
      }
      
      # Initialize fzf if available
      if command -v fzf &>/dev/null; then
          eval "$(fzf --zsh)"
      fi
      
      # Initialize starship
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      
      # Only source if the file exists
      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';
  };
  
  programs.starship.enable = true;
  imports = [ ./starship.nix ];
  
  home.packages = with pkgs; [
    fzf
    eza
    duf
    trash-cli
    nix-index
    fd
    ripgrep
    bat
  ];
}
