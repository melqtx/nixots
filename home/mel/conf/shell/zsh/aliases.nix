{ config, pkgs }:
{
  la = "run exa -l";
  ls = "ls --color=auto";
  nf = "run neofetch";
  sa = "pkill ags ; ags & disown";
  suda = "sudo -E -s";
  sh = "swayhide";
  nix-pkgs = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs";
  rebuild = "sudo nixos-rebuild switch --flake /home/mel/nixos-config#melqtx";
  
  da = "date \"+%Y-%m-%d %A %T %Z\"";
  mv = "mv -i";
  rm = "trash -v";
  mkdir = "mkdir -p";
  
  ps = "ps auxf";
  ping = "ping -c 10";
  less = "less -R";
  cls = "clear";
  c = "clear";
  svi = "sudo vi";
  
  "cd.." = "cd ..";
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";
  ".3" = "cd ../../..";
  ".4" = "cd ../../../..";
  ".5" = "cd ../../../../..";
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
  fastfetch = "fastfetch --logo-type kitty";
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
  
  un = "nix-env -e";
  up = "nixos-rebuild switch --flake /home/mel/nixos-config#melqtx";
  pl = "nix-env -q";
  pa = "nix search nixpkgs";
  
  l = "eza -lh --icons=auto";
  ll = "eza -lha --icons=auto --sort=name --group-directories-first";
  ld = "eza -lhD --icons=auto";
  lt = "eza --icons=auto --tree";
  
  vc = "code";
  
  ffec = "_fuzzy_edit_search_file_content";
  ffcd = "_fuzzy_change_directory";
  ffe = "_fuzzy_edit_search_file";
  df = "_df";
}
