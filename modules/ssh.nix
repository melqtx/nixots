{ config, lib, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 5555 ];
    
    settings = {
      PasswordAuthentication = true;
      PubkeyAuthentication = true;
      KbdInteractiveAuthentication = true;
      PermitEmptyPasswords = false;
      PermitRootLogin = "yes";
      
      AllowUsers = [ "mel"];
      
      
      X11Forwarding = false;
      AllowTcpForwarding = "local";
      AllowAgentForwarding = true;
    };
    

  };
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 5555 ];
  };
  
  services.fail2ban = {
    enable = true;
    
    jails = {
      sshd = {
        settings = {
          enabled = true;
          port = "5555";
          findtime = "10m";
        };
      };
    };
  };
}
