{ config, pkgs, ... }:

{

  imports = [ ../picom/picom.nix
              ../../common/apps/terminal/kitty.nix
              #( import ../../app/dmenu-scripts/networkmanager-dmenu.nix {dmenu_command = "rofi -show dmenu"; inherit pkgs;})
            ];

  home.packages = with pkgs; [
    networkmanagerapplet
    dunst
    autorandr
    #alacritty
    kitty
    dmenu
    rofi
    keepmenu
    networkmanager_dmenu
    feh
    flameshot
    alttab
    xdotool
    xclip
    ddcutil
    sct
    libnotify
    xorg.xkill
    killall
    bottom
    brightnessctl
    xorg.xcursorthemes
    xorg.xev
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  programs.feh.enable = true;
  programs.rofi.enable = true;

  services.autorandr.enable = true;
  programs.autorandr.enable = true;
}

