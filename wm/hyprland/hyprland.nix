{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    polkit_gnome

    # Clipboard
    wl-clipboard
    cliphist
    wl-clip-persist

    # So perrty!
    swaybg
    waypaper

    # XDG Portal Setup
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  imports = [
    ../../common/apps/terminal/kitty.nix # config for Kitty
    ../../common/git.nix # git config
    # ../wm/hyprland/dbus.nix # dbus
     ./fuzzel.nix # fuzzel
    ./fnott.nix # fnott for notifications
    ../../common/bars/waybar.nix
  ];

  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Snow";
    size = 36;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {};
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
      exec-once = hyprctl setcursor Quintom_Snow 36

      exec-once = waybar
      exec-once = waypaper --restore
      #exec-once = emacs -daemon

      general {
        layout = master
        cursor_inactive_timeout = 30
        gaps_in = 7
        gaps_out = 7
      }

      misc {
        #disable_hyprland_logo = true
        disable_splash_rendering = true
        force_default_wallpaper = 0
      }

      $mainMod = SUPER
      bind=$mainMod, RETURN, exec, kitty
      bind=$mainMod, Space, exec, fuzzel
      bind=$mainMod, e, exec, emacs
      bind=$mainMod, f, exec, thunar
      bind=$mainMod, v, exec, cliphist list | fuzzel -d | cliphist decode | wl-copy
      bind=$mainMod, w, exec, firefox
      bind=$mainMod, x, exec, fnottctl dismiss
      bind=$mainMod CTRL, l, exec, swaylock
      bind=$mainMod SHIFT, T, togglefloating
      bind=$mainMod SHIFT, Q, exit
      bind=$mainMod SHIFT, X, exec, fnottctl dismiss all

      monitor=Virtual-1,1680x1050,auto,1
      monitor=,1680x1050,auto,1
    '';
    systemd.enable = true;
  };
}
