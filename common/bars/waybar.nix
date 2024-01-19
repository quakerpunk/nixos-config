{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        margin-bottom = 0;
        margin-top = 0;
        position = "top";
        spacing = 2;
        modules-left = [ "custom/os" "cpu" "memory" "custom/disk_root" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "custom/updates" "idle_inhibitor" "network" "tray" "clock#date" "clock#time"];
        "custom/os" = {
          "format" = " {} ";
          "exec" = ''echo "" '';
          "interval" = "once";
        };
        # For any laptops.
        battery = {
          "states" = {
            # "good" = 95;
            "warning" = 30;
            "critical" = 15;
          },
          "format" = "{icon}   {capacity}%";
          "format-charging" = "  {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-alt" = "{icon}  {time}";
           # "format-good" = ""; // An empty format will hide the module
           # "format-full" = "";
          "format-icons" = [" ", " ", " ", " ", " "];
        };
        "custom/disk_root": {
          "format" = "💽 {} ";
          "interval" = 30;
          "exec" = "df -h --output=avail / | tail -1 | tr -d ' '";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "tooltip" = true;
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          },
          "on-click-right" = "swaylock";
        };
      };
    };
    style = ''
      * {
        /*font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;*/
        font-family: FontAwesome, Helvetica, Arial, sans-serif;
        border: none;
        border-radius: 0px;
      }
      window#waybar {
        background-color: rgba(0,0,0,0.2);
        /* color: #FFFFFF; */
        transition-property: background-color;
        transition-duration: .5s;
      }

      #workspaces {
          background: #FFFFFF;
          margin: 5px 1px 6px 1px;
          padding: 0px 1px;
          border-radius: 15px;
          border: 0px;
          font-weight: bold;
          font-style: normal;
          opacity: 0.8;
          font-size: 16px;
          color: #FFFFFF;
      }
    '';
  };
}
