
{ config, lib, pkgs, ... }:

{
  networking = {
    firewall.allowedUDPPorts = [ 5353 ];

    extraHosts = ''
      127.0.0.1 ww.instagram.com
#      127.0.0.1 reddit.com
#      127.0.0.1 www.reddit.com
#      127.0.0.1 old.reddit.com

    '';

  };

}
