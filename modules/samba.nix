
{ config, lib, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 5555 ];
    
    settings = {
      PasswordAuthentication = true;
      PubkeyAuthentication = true;
      PermitEmptyPasswords = false;
      PermitRootLogin = "no";
      
      AllowUsers = [ "mel"];
      
      
      X11Forwarding = false;
      AllowTcpForwarding = "local";
      AllowAgentForwarding = false;
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
