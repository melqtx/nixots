{ config, pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "sambauser";
    group = "sambauser";
    dataDir = "/var/lib/jellyfin";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/jellyfin 0755 sambauser sambauser -"
    "d /home/media 0755 sambauser sambauser -"
  ];

  users.groups.sambauser = {};
  
  users.users.sambauser = {
    isSystemUser = true;
    group = "sambauser";
    extraGroups = [ "jellyfin" ];
  };
}
