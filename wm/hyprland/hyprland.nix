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

    #Webkit for Emacs
  ];

  imports = [
    ../../common/apps/terminal/kitty.nix # config for Kitty
    ../../common/apps/browsers/firefox.nix
    ../../common/apps/editors/doom.nix
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
    xwayland = { enable = true; };
    systemd.enable = true;
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
      exec-once = hyprctl setcursor Vanilla_DMZ 24

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
      bind=$mainMod, q, killactive
      bind=$mainMod, v, exec, cliphist list | fuzzel -d | cliphist decode | wl-copy
      bind=$mainMod, w, exec, firefox
      bind=$mainMod, x, exec, fnottctl dismiss
      bind=$mainMod CTRL, l, exec, swaylock
      bind=$mainMod SHIFT, T, togglefloating
      bind=$mainMod SHIFT, Q, exit
      bind=$mainMod SHIFT, X, exec, fnottctl dismiss all

      bind=$mainMod SHIFT,SPACE,fullscreen,1
      bind=ALT,TAB,cyclenext
      bind=ALT,TAB,bringactivetotop
      bind=ALTSHIFT,TAB,cyclenext,prev
      bind=ALTSHIFT,TAB,bringactivetotop

      bind=$mainMod,H,movefocus,l
      bind=$mainMod,J,movefocus,d
      bind=$mainMod,K,movefocus,u
      bind=$mainMod,L,movefocus,r

      bind=$mainMod SHIFT,H,movewindow,l
      bind=$mainMod SHIFT,J,movewindow,d
      bind=$mainMod SHIFT,K,movewindow,u
      bind=$mainMod SHIFT,L,movewindow,r

      # Switch workspaces with mainMod + [0-9]
      # Taken from Hyprland default config.
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind=$mainMod SHIFT,1,movetoworkspace,1
      bind=$mainMod SHIFT,2,movetoworkspace,2
      bind=$mainMod SHIFT,3,movetoworkspace,3
      bind=$mainMod SHIFT,4,movetoworkspace,4
      bind=$mainMod SHIFT,5,movetoworkspace,5
      bind=$mainMod SHIFT,6,movetoworkspace,6
      bind=$mainMod SHIFT,7,movetoworkspace,7
      bind=$mainMod SHIFT,8,movetoworkspace,8
      bind=$mainMod SHIFT,9,movetoworkspace,9

      bind=$mainMod CTRL,right,workspace,+1
      bind=$mainMod CTRL,left,workspace,-1

      env=WLR_NO_HARDWARE_CURSORS,1

      monitor=Virtual-1,1680x1050,auto,1
      monitor=,1680x1050,auto,1
    '';
  };
}
