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
    
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      save = 10000;
      size = 10000;
      share = true;
    };
    
    shellAliases = import ./aliases.nix { inherit config pkgs; };
    
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_DATA_DIRS = "$XDG_DATA_HOME:/usr/local/share:/usr/share";
      LESSHISTFILE = "/tmp/less-hist";
      HISTFILE = "$HOME/.zsh_history";
      PARALLEL_HOME = "$XDG_CONFIG_HOME/parallel";
      SCREENRC = "$XDG_CONFIG_HOME/screen/screenrc";
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#928374,bg=none,bold,underline";
    };
    
    setOptions = [
      "EXTENDED_HISTORY"
      "INC_APPEND_HISTORY"
      "SHARE_HISTORY"
      "HIST_EXPIRE_DUPS_FIRST"
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_ALL_DUPS"
    ];
    
    initExtra = ''
      bindkey "^[[H" beginning-of-line
      bindkey "^[[4~" end-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char
      
      export PATH=${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/share/nvim/mason/bin:$PATH
      export COLS=${colors.background}\ ${colors.foreground}\ ${colors.color1}\ ${colors.color2}\ ${colors.color3}\ ${colors.color4}\ ${colors.color5}\ ${colors.color6}\ ${colors.color7}\ ${colors.color8}\ ${colors.color9}\ ${colors.color10}\ ${colors.color11}\ ${colors.color12}\ ${colors.color13}\ ${colors.color14}\ ${colors.color15}\ ${colors.mbg}\ ${colors.color0}\ ${colors.comment}
      export LD_LIBRARY_PATH=${config.home.homeDirectory}/.config/awesome:${pkgs.lua54Packages.lua}/lib/:${pkgs.pam}/lib
      
      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
      
      function command_not_found_handler {
          local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
          printf "''${green}zsh''${reset}: command ''${purple}NOT''${reset} found: ''${bright}'%s'''${reset}\n" "$1"
          
          if command -v nix-locate &>/dev/null; then
              printf "''${bright}Searching for packages that provide '''${bright}%s''${green}'...\n''${reset}" "''${1}"
              nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/''${1}"
          fi
          return 127
      }
      
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

      _fuzzy_edit_search_file_content() {
          local selected_file
          selected_file=$(grep -irl "''${1:-}" ./ | fzf --height "80%" --layout=reverse --preview-window right:60% --cycle --preview 'cat {}' --preview-window right:60%)

          if [[ -n "$selected_file" ]]; then
              if command -v "$EDITOR" &>/dev/null; then
                  "$EDITOR" "$selected_file"
              else
                  echo "EDITOR is not specified. using vim."
                  vim "$selected_file"
              fi
          else
              echo "No file selected or search returned no results."
          fi
      }

      _fuzzy_edit_search_file() {
          local initial_query="$1"
          local selected_file
          local fzf_options=()
          fzf_options+=(--height "80%" --layout=reverse --preview-window right:60% --cycle)
          local max_depth=5

          if [[ -n "$initial_query" ]]; then
              fzf_options+=("--query=$initial_query")
          fi

          selected_file=$(find . -maxdepth $max_depth -type f 2>/dev/null | fzf "''${fzf_options[@]}")

          if [[ -n "$selected_file" && -f "$selected_file" ]]; then
              if command -v "$EDITOR" &>/dev/null; then
                  "$EDITOR" "$selected_file"
              else
                  echo "EDITOR is not specified. using vim."
                  vim "$selected_file"
              fi
          else
              return 1
          fi
      }

      _df() {
          if [[ $# -ge 1 && -e "''${@: -1}" ]]; then
              duf "''${@: -1}"
          else
              duf
          fi
      }
      
      if command -v fzf &>/dev/null; then
          eval "$(fzf --zsh)"
      fi
      
      autoload -U compinit && compinit
      
      [[ -f $HOME/.user.zsh ]] && source $HOME/.user.zsh
      [[ -f $HOME/.hyde.zshrc ]] && source $HOME/.hyde.zshrc
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration\n[ ](fg:blue)  ";
      git_branch.format = "via [$symbol$branch(:$remote_branch)]($style) ";
      command_timeout = 1000;
    };
  };
  
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
