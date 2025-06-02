
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ntfy-sh
  ];

  systemd.services.jellyfin = {
    postStart = ''
      ${pkgs.ntfy-sh}/bin/ntfy publish \
        --title "Jellyfin Started" \
        --message "Jellyfin service started successfully at $(${pkgs.coreutils}/bin/date)" \
        samba-media-notifications
    '';
    
    postStop = ''
      ${pkgs.ntfy-sh}/bin/ntfy publish \
        --title "Jellyfin Stopped" \
        --message "Jellyfin service stopped at $(${pkgs.coreutils}/bin/date)" \
        samba-media-notifications
    '';
  };
}
