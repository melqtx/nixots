{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 1408 ];
    
    settings = {
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
      AuthenticationMethods = "publickey";
      PermitEmptyPasswords = false;
      ChallengeResponseAuthentication = false;
      KbdInteractiveAuthentication = false;
      UsePAM = false;
      
      PermitRootLogin = "no";
      
      AllowUsers = [ "mel" ];
      DenyUsers = [ "root" ];
      
      MaxAuthTries = 3;
      MaxSessions = 3;
      MaxStartups = "10:30:60";
      LoginGraceTime = 30;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
      
      Protocol = 2;
      Compression = false;
      TCPKeepAlive = true;
      
      X11Forwarding = false;
      AllowTcpForwarding = "local";
      AllowStreamLocalForwarding = false;
      GatewayPorts = "no";
      PermitTunnel = "no";
      AllowAgentForwarding = false;
      
      StrictModes = true;
      IgnoreRhosts = true;
      HostbasedAuthentication = false;
      PermitUserEnvironment = false;
      AcceptEnv = "LANG LC_*";
      
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
      ];
      
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "diffie-hellman-group-exchange-sha256"
      ];
      
      Macs = [
        "umac-128-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "hmac-sha2-512-etm@openssh.com"
        "umac-128@openssh.com"
        "hmac-sha2-256"
        "hmac-sha2-512"
      ];
      
      HostKeyAlgorithms = [
        "rsa-sha2-512"
        "rsa-sha2-256"
        "ssh-ed25519"
      ];
      
      PubkeyAcceptedAlgorithms = [
        "ssh-ed25519"
        "rsa-sha2-512"
        "rsa-sha2-256"
      ];
    };
    
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];
  };
  
  networking.firewall = {
    allowedTCPPorts = [ 2222 ];
    
    extraCommands = ''
      iptables -A INPUT -p tcp --dport 2222 -m state --state NEW -m recent --set --name SSH
      iptables -A INPUT -p tcp --dport 2222 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 --name SSH -j DROP
    '';
    
    extraStopCommands = ''
      iptables -D INPUT -p tcp --dport 2222 -m state --state NEW -m recent --set --name SSH 2>/dev/null || true
      iptables -D INPUT -p tcp --dport 2222 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 --name SSH -j DROP 2>/dev/null || true
    '';
  };
  
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "1h";
    findtime = "10m";
    
    jails = {
      sshd = ''
        enabled = true
        port = 2222
        filter = sshd
        logpath = /var/log/auth.log
        maxretry = 3
        bantime = 3600
        findtime = 600
        action = iptables[name=SSH, port=2222, protocol=tcp]
      '';
    };
  };
  
  environment.systemPackages = with pkgs; [
    openssh
    fail2ban
  ];
}
