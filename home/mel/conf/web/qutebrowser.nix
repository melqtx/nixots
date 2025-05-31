#SafriXV config
{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.qutebrowser = {
    enable = true;
    quickmarks = {
      nixguide = "https://ianthehenry.com/posts/how-to-learn-nix/glossary/";
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      home-manager = "https://github.com/nix-community/home-manager";
      ChatGPT = "https://chatgpt.com/";
      nix = "https://search.nixos.org/packages";
      dots = lib.mkForce "https://gitlab.com/melqtx/dots";
      syncthing = "http://127.0.0.1:8384/";
      discord = "https://discord.com/channels/@me";
      calendar = "https://calendar.proton.me/u/0/";
      d2l = "https://stcloudstate.learn.minnstate.edu/d2l/home";
      org-pomodoro = "https://github.com/marcinkoziej/org-pomodoro";
      org-pom-poly = "https://colekillian.com/posts/org-pomodoro-and-polybar/";
      TeX = "https://www.emacswiki.org/emacs/TeXInputMethod";
      org-super-agenda = "https://github.com/alphapapa/org-super-agenda";
      org-timeblock = "https://github.com/ichernyshovvv/org-timeblock?tab=readme-ov-file";
      cs50p = "https://cs50.harvard.edu/python/2022/psets/";
      python = "https://docs.python.org/3/library/stdtypes.html#string-methods";
      mushoku = "https://novelasligeras.net/wp-content/uploads/2021/04/Mushoku-Tensei-Isekai-Ittara-Honki-Dasu-Vol1-0-719x1024.jpg";
      dokusei = "https://gitlab.com/melqtx/dokusei";
      mallet-suplies = "https://www.advantagenetworkinc.com/percussion-music";
      MyNixOS = "https://mynixos.com/";
      jimaku = "https://jimaku.cc/";
      accountability = "https://docs.google.com/spreadsheets/d/1HXf44KiAhbDQ-EwAQPng4feL96exGeLk-YNCrfPf0QI/edit?usp=sharing";
      lessons = "https://docs.google.com/document/d/1zRl7fsUPSSfkVVvrb2tM4pP_deVhampzkB_kkOLac3c/edit?tab=t.0";
      shana = "https://www.shanaproject.com/";
      myanonamouse = "https://www.myanonamouse.net/index.php";
      schedule = "https://schedulebuilder.umn.edu/";
      joe = "https://joehisaishi-concert.com/sgfc2025-ja/#02";
    };

    settings = {
      # Tokyo Night color scheme
      colors = {
        completion.category.bg = "#1a1b26";
        completion.category.fg = "#a9b1d6";
        completion.even.bg = "#1a1b26";
        #        completion.even.fg = "#a9b1d6";
        completion.odd.bg = "#1a1b26";
        #        completion.odd.fg = "#a9b1d6";
        completion.fg = "#a9b1d6";
        completion.match.fg = "#7aa2f7";
        completion.item.selected.bg = "#7aa2f7";
        completion.item.selected.fg = "#a9b1d6";
        statusbar.normal.bg = "#1a1b26";
        statusbar.normal.fg = "#a9b1d6";
        statusbar.insert.bg = "#7aa2f7";
        statusbar.insert.fg = "#1a1b26";
        statusbar.command.bg = "#1a1b26";
        statusbar.command.fg = "#a9b1d6";
        statusbar.url.success.http.fg = "#9ece6a";
        statusbar.url.success.https.fg = "#9ece6a";
        tabs.bar.bg = "#1a1b26";
        tabs.even.bg = "#1a1b26";
        tabs.even.fg = "#a9b1d6";
        tabs.odd.bg = "#1a1b26";
        tabs.odd.fg = "#a9b1d6";
        tabs.selected.even.bg = "#7aa2f7";
        tabs.selected.even.fg = "#a9b1d6";
        tabs.selected.odd.bg = "#7aa2f7";
        tabs.selected.odd.fg = "#a9b1d6";
        hints.bg = "#e0af68";
        hints.fg = "#1a1b26";
        hints.match.fg = "#a9b1d6";
        messages.info.bg = "#1a1b26";
        messages.info.fg = "#a9b1d6";
        messages.error.bg = "#f7768e";
        messages.error.fg = "#a9b1d6";
        keyhint.bg = "#1a1b26";
        keyhint.fg = "#a9b1d6";
        keyhint.suffix.fg = "#7dcfff";
        webpage.bg = "#1a1b26";
      };
    };

  };
}
