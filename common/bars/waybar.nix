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
        spacing = 6;
        modules-left = [ "hyprland/workspaces" "cpu" "memory" "custom/disk_root" ];
        modules-center = [ "clock#date" "custom/os" "clock#time" ];
        modules-right = [ "custom/updates" "idle_inhibitor" "network" "tray" ];
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
          };
          "format" = "{icon}   {capacity}%";
          "format-charging" = "  {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-alt" = "{icon}  {time}";
           # "format-good" = ""; // An empty format will hide the module
           # "format-full" = "";
          "format-icons" = [" " " " " " " " " "];
        };
        "clock#date" = {
          "format" = "{:%a %m/%d/%Y}";
          "format-alt" = "{:%H:%M}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode"          = "year";
            "mode-mon-col"  = 3;
            "weeks-pos"     = "right";
            "on-scroll"     = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" =     "<span color='#ffead3'><b>{}</b></span>";
              "days" =       "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" =      "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" =   "<span color='#ffcc66'><b>{}</b></span>";
              "today" =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          "actions" =  {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        "clock#time" = {
          "interval" = 60;
          "format" = "{:%H:%M}";
          "max-length" = 25;
        };
        "custom/disk_root" = {
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
          };
          "on-click-right" = "swaylock";
        };
      };
    };
    style = ''
      * {
        /*font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;*/
        font-family: FontAwesome, "NotoSans Nerd Font Mono";
        font-size: 14px;
        border: none;
        border-radius: 0px;
      }
      window#waybar {
        background-color: transparent;
        /* background-color: rgba(0,0,0,0.2); */
        color: #A9B1D6;
        /* transition-property: background-color; */
        /* transition-duration: .5s; */
      }
      #workspaces {
        background-color: transparent;
        border: 1px solid #333331;
        border-radius: 4px;
        margin-top: 0;
        margin-bottom: 0;
      }
      #workspaces button {
        background-color: #1A1B26;
        color: #A9B1D6;
        border-radius: 10px;
        transition: all 0.3s ease;
        margin-right: 10;
      }
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background-color: #787C99;
        color: #A9B1D6;
        min-width: 30px;
        transition: all 0.3s ease;
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: #2F3549;
        color: #A9B1D6;
        min-width: 30px;
        transition: all 0.3s ease;
        animation: colored-gradient 10s ease infinite;
      }
      /* #workspaces button.focused:hover,
      #workspaces button.active:hover {
        background-color: #A9B1D6;
        transition: all 1s ease;
      } */

      #workspaces button.urgent {
        background-color: #F7768E;
        color: #1A1B26;
        transition: all 0.3s ease;
      }

      /* #workspaces button.hidden {} */

      #taskbar {
        border-radius: 8px;
        margin-top: 4px;
        margin-bottom: 4px;
        margin-left: 1px;
        margin-right: 1px;
      }

      #taskbar button {
        color: #A9B1D6;
        padding: 1px 8px;
        margin-left: 1px;
        margin-right: 1px;
      }

      #taskbar button:hover {
        background: transparent;
        border: 1px solid #2F3549;
        border-radius: 8px;
        transition: all 0.3s ease;
        animation: colored-gradient 10s ease infinite;
      }

      /* #taskbar button.maximized {} */

      /* #taskbar button.minimized {} */

      #taskbar button.active {
        border: 1px solid #2F3549;
        border-radius: 8px;
        transition: all 0.3s ease;
        animation: colored-gradient 10s ease infinite;
      }

      /* #taskbar button.fullscreen {} */

      /* -------------------------------------------------------------------------------- */

      #custom-launcher,
      /* #window, */
      #submap
      #mode,
      /* #tray, */
      #cpu,
      #memory,
      #backlight,
      #window  { background-color: #1A1B26; }
      #pulseaudio.audio { background-color: #1A1B26; }
      #pulseaudio.microphone,
      #network { background-color: #1A1B26; }
      #bluetooth  { background-color: #1A1B26; }
      #battery  { background-color: #1A1B26; }
      /* #clock { background-color: #1A1B26; } */
      #clock.time, #clock.date { background-color: transparent; }
      #custom-powermenu,

      #custom-notification {
        background-color: transparent;
        color: #A9B1D6;
        padding: 1px 8px;
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 2px;
        margin-right: 2px;
        border-radius: 20px;
        transition: all 0.3s ease;
      }

      #submap {
        background-color: #1A1B26;
        border: 0;
      }

      /* If workspaces is the leftmost module, omit left margin */
      /* .modules-left > widget:first-child > #workspaces, */
      .modules-left > widget:first-child > #workspaces button,
      .modules-left > widget:first-child > #taskbar button,
      .modules-left > widget:first-child > #custom-launcher,
      .modules-left > widget:first-child > #window,
      .modules-left > widget:first-child > #tray,
      .modules-left > widget:first-child > #cpu,
      .modules-left > widget:first-child > #memory,
      .modules-left > widget:first-child > #backlight,
      .modules-left > widget:first-child > #pulseaudio.audio,
      .modules-left > widget:first-child > #pulseaudio.microphone,
      .modules-left > widget:first-child > #network,
      .modules-left > widget:first-child > #bluetooth,
      .modules-left > widget:first-child > #battery,
      .modules-left > widget:first-child > #clock,
      .modules-left > widget:first-child > #custom-powermenu,
      .modules-left > widget:first-child > #custom-notification {
        margin-left: 5px;
      }

      /* If workspaces is the rightmost module, omit right margin */
      /* .modules-right > widget:last-child > #workspaces, */
      /* .modules-right > widget:last-child > #workspaces, */
      .modules-right > widget:last-child > #workspaces button,
      .modules-right > widget:last-child > #taskbar button,
      .modules-right > widget:last-child > #custom-launcher,
      .modules-right > widget:last-child > #window,
      .modules-right > widget:last-child > #tray,
      .modules-right > widget:last-child > #cpu,
      .modules-right > widget:last-child > #memory,
      .modules-right > widget:last-child > #backlight,
      .modules-right > widget:last-child > #pulseaudio.audio,
      .modules-right > widget:last-child > #pulseaudio.microphone,
      .modules-right > widget:last-child > #network,
      .modules-right > widget:last-child > #bluetooth,
      .modules-right > widget:last-child > #battery,
      .modules-right > widget:last-child > #clock,
      .modules-right > widget:last-child > #custom-powermenu,
      .modules-right > widget:last-child > #custom-notification {
        margin-right: 5px;
      }

      /* -------------------------------------------------------------------------------- */

      #tray {
        background-color: #1A1B26;
        padding: 1px 8px;
      }
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #F7768E;
      }
    '';
  };
}
