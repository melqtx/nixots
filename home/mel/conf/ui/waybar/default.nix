{ config, lib, pkgs, colors, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar; # You can change this to waybar-hyprland if available
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    
    style = with colors; ''
      window#waybar {
        background-color: #${background};
        color: #${foreground};
        border-bottom: none;
        font-family: "Iosevka Nerd Font", "Material Design Icons Desktop";
      }
      
      #workspaces {
        font-family: "Material Design Icons Desktop";
        font-size: 20px;
        background-color: #${color0}; /* Using color0 as module background */
        margin: 4px 0;
        border-radius: 5px;
      }
      
      #workspaces button {
        font-size: 18px;
        background-color: transparent;
        color: #${color5};
        transition: all 0.1s ease;
        padding: 0 8px;
      }
      
      #workspaces button.focused {
        font-size: 18px;
        color: #${color3};
        background-color: rgba(${color3-rgb}, 0.2);
      }
      
      #workspaces button.persistent {
        color: #${color1};
        font-size: 12px;
      }
      
      #workspaces button:hover {
        background-color: rgba(${color5-rgb}, 0.1);
      }
      
      #custom-launcher {
        background-color: #${color0};
        color: #${color4};
        margin: 4px 4.5px;
        padding: 5px 12px;
        font-size: 18px;
        border-radius: 5px;
      }
      
      #custom-launcher:hover {
        background-color: rgba(${color4-rgb}, 0.1);
      }
      
      #custom-power {
        color: #${color1};
        background-color: #${color0};
        margin: 4px 4.5px 4px 4.5px;
        padding: 5px 11px 5px 13px;
        border-radius: 5px;
      }
      
      #custom-power:hover {
        background-color: rgba(${color1-rgb}, 0.1);
      }
      
      #clock {
        background-color: #${color0};
        color: #${color7};
        margin: 4px 9px;
        padding: 5px 12px;
        border-radius: 5px;
        font-weight: bold;
      }
      
      #network {
        color: #${color7};
        background-color: #${color0};
        margin: 4px 0 4px 4.5px;
        padding: 5px 12px;
        border-radius: 5px 0 0 5px;
      }
      
      #battery {
        color: #${color2};
        background-color: #${color0};
        margin: 4px 0px;
        padding: 5px 12px;
        border-radius: 0 5px 5px 0;
      }
      
      #battery.charging {
        color: #${color3};
      }
      
      #battery.critical:not(.charging) {
        background-color: #${color1};
        color: #${background};
        animation: blink 0.5s linear infinite alternate;
      }
      
      @keyframes blink {
        to {
          background-color: #${background};
          color: #${color1};
        }
      }
      
      #tray {
        background-color: #${color0};
        margin: 4px 4.5px;
        padding: 2px 8px;
        border-radius: 5px;
      }
      
      * {
        font-size: 16px;
        min-height: 0;
        font-family: "Iosevka Nerd Font", "Material Design Icons Desktop";
        border: none;
        border-radius: 0;
      }
    '';
    
    settings = [{
      height = 35;
      layer = "top";
      position = "top";
      tray = { 
        spacing = 10;
        icon-size = 16;
      };
      
      modules-center = [ "clock" ];
      modules-left = [ "custom/launcher" "hyprland/workspaces" ];
      modules-right = [
        "network"
        "battery" 
        "tray"
        "custom/power"
      ];
      
      "hyprland/workspaces" = {
        on-click = "activate";
        all-outputs = true;
        format = "{icon}";
        disable-scroll = true;
        active-only = false;
        format-icons = {
          default = "󰊠";
          persistent = "󰊠";
          focused = "󰮯";
          urgent = "󰀨";
        };
        persistent_workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
          "5" = [ ];
        };
      };
      
      battery = {
        interval = 60;
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰚦 {capacity}%";
        format-icons = [ 
          "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" 
          "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" 
        ];
        states = {
          critical = 15;
          warning = 30;
        };
        tooltip-format = "Battery: {capacity}%\nTime: {time}";
      };
      
      clock = {
        interval = 1;
        format = "{:%d %A %H:%M}";
        format-alt = "{:%Y-%m-%d %H:%M:%S}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      
      network = {
        interval = 5;
        format-wifi = "󰤨 {signalStrength}%";
        format-ethernet = "󰈀 Connected";
        format-disconnected = "󰤮 Disconnected";
        tooltip-format-wifi = "WiFi: {essid}\nSignal: {signalStrength}%\nFrequency: {frequency}MHz";
        tooltip-format-ethernet = "Ethernet: {ifname}\nIP: {ipaddr}";
        on-click = "nm-connection-editor";
      };
      
      "custom/launcher" = {
        format = "󱄅";
        on-click = "rofi -show drun";
        tooltip = false;
      };
      
      "custom/power" = {
        format = "⏻";
        on-click = "systemctl suspend";
        tooltip = "Suspend system";
      };
    }];
  };
}
