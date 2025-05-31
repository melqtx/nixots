{ 
  config,
  lib,
  pkgs,
  ...
}:


let
  colors = import ../../../../shared/cols/horizon.nix {};
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      la = "run exa -l";
      ls = "ls --color=auto";
      v = "nvim";
      nf = "run neofetch";
      sa = "pkill ags ; ags & disown";
      suda = "sudo -E -s";
      sh = "swayhide";
      nix-pkgs = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs";
      rebuild = "sudo nixos-rebuild switch --flake /home/mel/nixos-config#melqtx";

      # Your aliases
      da = "date \"+%Y-%m-%d %A %T %Z\"";
      mv = "mv -i";
      rm = "trash -v";
      vim = "nvim";
      iv = "nvim";
      ivm = "nvim";
      vi = "nvim";
      vis = "nvim \"+set si\"";
      mkdir = "mkdir -p";
      ps = "ps auxf";
      ping = "ping -c 10";
      less = "less -R";
      cls = "clear";
      svi = "sudo vi";
      "cd.." = "cd ..";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      bd = "cd \"$OLDPWD\"";
      rmd = "/bin/rm --recursive --force --verbose";
      h = "history | grep ";
      p = "ps aux | grep ";
      topcpu = "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10";
      f = "find . | grep ";
      countfiles = "for t in files links directories; do echo `find . -type \${t:0:1} | wc -l` \$t; done 2> /dev/null";
      rebootsafe = "sudo shutdown -r now";
      rebootforce = "sudo shutdown -r -n now";
      logs = "sudo find /var/log -type f -exec file {} \\; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f";
      nerdfetch = "fm6000";
      update = "sudo pacman -Syu && yay -Syu";
      whatsmyip = ''
        if command -v ip &> /dev/null; then
          echo -n "Internal IP: "
          ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
        else
          echo -n "Internal IP: "
          ifconfig wlan0 | grep "inet " | awk '{print $2}'
        fi
      '';
    };
    history = {
      expireDuplicatesFirst = true;
      save = 512;
    };
    initContent = ''
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[4~"   end-of-line
      bindkey  "^[[3~"  delete-char
      export PATH=${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/share/nvim/mason/bin:$PATH
      export COLS=${colors.background}\ ${colors.foreground}\ ${colors.color1}\ ${colors.color2}\ ${colors.color3}\ ${colors.color4}\ ${colors.color5}\ ${colors.color6}\ ${colors.color7}\ ${colors.color8}\ ${colors.color9}\ ${colors.color10}\ ${colors.color11}\ ${colors.color12}\ ${colors.color13}\ ${colors.color14}\ ${colors.color15}\ ${colors.mbg}\ ${colors.color0}\ ${colors.comment}
      export LD_LIBRARY_PATH=${config.home.homeDirectory}/.config/awesome:${pkgs.lua54Packages.lua}/lib/:${pkgs.pam}/lib
      
      # Only source if the file exists
      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration\n[ ](fg:blue)  ";
      git_branch.format = "via [$symbol$branch(:$remote_branch)]($style) ";
      command_timeout = 1000;
    };
  };
}
