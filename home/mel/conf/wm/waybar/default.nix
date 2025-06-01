{ config, lib, pkgs, hyprland, colors, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        font-weight: bold;
        min-height: 0;
        border: none;
        border-radius: 0;
      }
      
      window#waybar {
        background-color: #1d2021;
        color: #ebdbb2;
        border-bottom: 2px solid #fe8019;
      }
      
      #workspaces {
        background-color: #1d2021;
        margin: 0;
        padding: 0 10px;
      }
      
      #workspaces button {
        background-color: transparent;
        color: #a89984;
        padding: 8px 12px;
        margin: 0 2px;
        border-bottom: 2px solid transparent;
        transition: all 0.2s ease;
      }
      
      #workspaces button.active {
        color: #fe8019;
        border-bottom: 2px solid #fe8019;
      }
      
      #workspaces button:hover {
        background-color: #3c3836;
        color: #fe8019;
      }
      
      #custom-separator {
        color: #fe8019;
        font-size: 16px;
        padding: 0 15px;
      }
      
      #clock {
        color: #ebdbb2;
        font-size: 11px;
        padding: 8px 15px;
      }
      
      #network {
        color: #ebdbb2;
        padding: 8px 10px;
      }
      
      #battery {
        color: #ebdbb2;
        padding: 8px 10px;
      }
      
      #battery.critical {
        color: #fb4934;
      }
      
      #pulseaudio {
        color: #ebdbb2;
        padding: 8px 15px;
      }
    '';
    settings = [{
      layer = "top";
      position = "top";
      height = 35;
      spacing = 0;
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      
      modules-left = [
        "hyprland/workspaces"
        "custom/separator"
      ];
      
      modules-center = [ ];
      
      modules-right = [
        "pulseaudio"
        "battery"
        "network"
        "clock"
      ];
      
      "hyprland/workspaces" = {
        on-click = "activate";
        all-outputs = true;
        format = "{icon}";
        disable-scroll = true;
        active-only = false;
        show-special = false;
        format-icons = {
          "1" = "cmd";
          "2" = "www";
          "3" = "dev";
          "4" = "chat";
          "5" = "sys";
          default = "misc";
        };
        persistent_workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
          "5" = [ ];
        };
      };
      
      "custom/separator" = {
        format = "";
        tooltip = false;
      };
      
      clock = {
        interval = 60;
        format = "{:%H:%M}";
        tooltip-format = "{:%A, %B %d, %Y}";
      };
      
      network = {
        format-disconnected = "󰤮 disconnected";
        format-ethernet = "󰒢 {ifname}";
        format-wifi = "󰖩 NetGear";
        interval = 5;
        tooltip = false;
      };
      
      battery = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰂂" ];
        states = {
          critical = 15;
          warning = 30;
        };
        tooltip = false;
      };
      
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰖁 muted";
        format-icons = {
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "pamixer -t";
        tooltip = false;
      };
    }];
  };
}
