{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shawnb";
  home.homeDirectory = "/home/shawnb";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    alacritty
    eza
    fd
    fnott
    kitty
    neofetch
    onefetch
    ripgrep
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shawnb/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../common/apps/terminal/kitty.nix # config for Kitty
    ../common/git.nix # git config
    ../common/shellgame.nix # zsh config
    ../wm/hyprland/fnott.nix # fnott for notifications
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
      exec-once = hyprctl setcursor Quintom_Snow 36

      #exec-once = waybar
      #exec-once = emacs --daemon

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
      bind=$mainMod, e, exec, emacs
      bind=$mainMod, f, exec, thunar
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
