
{
  config,
  lib,
  pkgs,
  ...
}:

let
  YAZI = "/home/mel/.config/yazi";
in

{
  home.file = {

    "${YAZI}/keymap.toml" = {
      source = ./keymap.toml;
    };

    "${YAZI}/theme.toml" = {
      source = ./theme.toml;
    };

    "${YAZI}/yazi.toml" = {
      source = ./yazi.toml;
    };

  };

  home.packages = with pkgs; [
    # Yazi Dependencies
    jq
    poppler
    p7zip
    fd
    rq
    fzf
    ffmpegthumbnailer
    zoxide
    imagemagick
  ];
}
