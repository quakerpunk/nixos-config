{ config, pkgs, ... }:

{

  imports = [ #../picom/picom.nix
    ../../common/apps/terminal/alacritty.nix
    #../../common/apps/terminal/kitty.nix
    ../../common/apps/editors/doom.nix
    ../../common/apps/browsers/firefox.nix
    ../../common/git.nix
    #( import ../../app/dmenu-scripts/networkmanager-dmenu.nix {dmenu_command = "rofi -show dmenu"; inherit pkgs;})
  ];

  home.packages = with pkgs; [
    networkmanagerapplet
    dunst
    autorandr
    #alacritty
    #kitty
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
    scrot
    picom
    nitrogen
    #webkitgtk
  ];

  home.file.".config/picom/picom.conf".source = ./picom.conf;
  home.file.".config/qtile/config.py".source = ./qtile.py;
  home.file.".config/qtile/colors.py".source = ./colors.py;
  home.file.".config/qtile/autostart.sh".source = ./autostart.sh;

  programs.feh.enable = true;
  programs.rofi.enable = true;

  services.autorandr.enable = true;
  programs.autorandr.enable = true;
}

