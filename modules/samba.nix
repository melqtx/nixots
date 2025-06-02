




{ services.samba = { enable = true; openFirewall = true;

settings = {
  global = {
    workgroup = "WORKGROUP";
    "server string" = "NixOS File Server";
    "netbios name" = "nixos-server";
    security = "user";
    "map to guest" = "bad user";
    "log file" = "/var/log/samba/log.%m";
    "max log size" = "50";
    "log level" = "2";
    "oplocks" = "yes";
    "level2 oplocks" = "yes";
    "socket options" = "TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=65536 SO_SNDBUF=65536";
    "smb encrypt" = "required";
  };

  shared = {
    path = "/home/shared";
    browseable = "yes";
    "read only" = "no";
    "guest ok" = "no";
    "create mask" = "0644";
    "directory mask" = "0755";
    comment = "Public shared folder";
    "vfs objects" = "recycle";
    "recycle:repository" = ".recycle";
    "recycle:keeptree" = "yes";
    "recycle:versions" = "yes";
    "recycle:touch" = "yes";
    "recycle:exclude" = "*.tmp";
  };

  media = {
    path = "/home/media";
    browseable = "yes";
    "read only" = "no";
    "guest ok" = "no";
    "create mask" = "0644";
    "directory mask" = "0755";
    comment = "Media files";
    "valid users" = "sambauser";
    "vfs objects" = "recycle";
    "recycle:repository" = ".recycle";
    "recycle:keeptree" = "yes";
    "recycle:versions" = "yes";
    "recycle:touch" = "yes";
    "recycle:exclude" = "*.tmp";
    "strict locking" = "no";
    "kernel oplocks" = "yes";
    "cache read" = "yes";
  };
};

};

systemd.tmpfiles.rules = [ "d /home/shared 0755 sambauser sambauser" "d /home/media 0755 sambauser sambauser" ];

environment.etc."scripts/monitor-media.sh" = {
  text = ''
    #!/run/current-system/sw/bin/bash
    set -x
    echo "Starting monitor-media.sh as $(whoami)" >&2
    echo "PATH is $PATH" >&2
    echo "Checking inotifywait: $(/run/current-system/sw/bin/inotifywait --version)" >&2
    echo "Checking ntfy: $(/run/current-system/sw/bin/ntfy --version)" >&2
    while /run/current-system/sw/bin/inotifywait -e create /home/media; do
        /run/current-system/sw/bin/ntfy publish --title "New File in Media Share" --message "A new file was uploaded to /home/media at $(date)" samba-media-notifications
    done
  '';
  mode = "0755";
};

environment.etc."scripts/check-samba-health.sh" = {
  text = ''
    #!/run/current-system/sw/bin/bash
    if ! systemctl is-active --quiet smb; then
        /run/current-system/sw/bin/ntfy publish --title "Samba Service Down" --message "Samba service is not running at $(date)" samba-media-notifications
    fi
    if ! systemctl is-active --quiet monitor-media; then
        /run/current-system/sw/bin/ntfy publish --title "Monitor Media Service Down" --message "Monitor media service is not running at $(date)" samba-media-notifications
    fi
  '';
  mode = "0755";
};

systemd.timers.check-samba-health = {
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnCalendar = "hourly";
    Persistent = true;
  };
};

systemd.services.check-samba-health = {
  description = "Check Samba services health";
  serviceConfig = {
    ExecStart = "/etc/scripts/check-samba-health.sh";
    User = "root";
  };
};

systemd.services.monitor-media = { description = "Monitor media share for new files"; after = [ "network.target" ]; wantedBy = [ "multi-user.target" ]; serviceConfig = { ExecStart = "/etc/scripts/monitor-media.sh"; Restart = "always"; User = "sambauser"; }; }; }
