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
    # alacritty
    #dconf
    eza
    fd
    nixfmt-classic
    neofetch
    onefetch
    ripgrep
    syncthing
    (pkgs.writeShellScriptBin "add-ssh-key" ''
      # Check if an SSH key path is provided as an argument
      if [ -z "$1" ]; then
        echo "Usage: $0 <path_to_ssh_key>"
        exit 1
      fi

      # Start the ssh-agent process
      eval "$(ssh-agent -s)"

      # Add the specified SSH key to the agent
      ssh-add "$1"
    '')
    (pkgs.writeShellScriptBin "hledger.sh" ''
      #!/bin/sh
      # hledger.sh
      # Kudos to acarrico for the original script.

      # The script is contingent on ledger-default-date-string
      # being set to "%Y-%m-%d", aka ISO date format.

      iargs=("$@")
      oargs=()
      j=0;
      date=;
      for((i=0; i<''${#iargs[@]}; ++i)); do
          case ''${iargs[i]} in
              --date-format)
                  # drop --date-format and the next arg
                  i=$((i+1));
                  ;;
              cleared) # for ledger-di
                  splay-balance-at-point
                  # convert "cleared" to "balance -N -C"
                  oargs[j]=balance; oargs[j+1]=-N; oargs[j+2]=-C; j=$((j+3));
                  ;;
              xact)
                  # convert "xact" to "print --match"
                  oargs[j]=print; oargs[j+1]=--match; j=$((j+2));
                  # drop xact argument and stash the date argument
                  i=$((i+1));
                  date=''${iargs[i]};
                  ;;
              # NOTE: Reconciliation still doesn't work for other reasons
              #       so the following filters/conversions are unnecessary for now.
              # --sort) # for reconcilliation
              #     # drop --sort and the next arg
              #     i=$((i+1));
              #     ;;
              # --uncleared) # for reconcilliation
              #     # convert "--uncleared" to "--unmarked --pending"
              #     oargs[j]=--unmarked; oargs[j+1]=--pending; j=$((j+2))
              #     ;;
              *)
                  # keep any other args:
                  oargs[j]=''${iargs[i]};
                  j=$((j+1));
                  ;;
          esac
      done

      if test "$date"
      then
          # substitute the given date for the old date:
          hledger "''\'''${oargs[@]}'" | sed "1s/....-..-../$date/"
      else
          # echo "''\'''${oargs[@]}'"
          hledger "''\'''${oargs[@]}'"
      fi
    '')
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
    ".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
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

  gtk = {
    enable = true;
    gtk3 = {
      extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintmedium";
        gtk-xft-rgba = "rgba";
      };
    };
    theme = {
      name = "SolArc-Dark";
      package = pkgs.solarc-gtk-theme;
    };
  };
  # Let Home Manager install and manage itself.
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    home-manager.enable = true;
  };

  imports = [
    ../wm/qtile/qtile.nix
    ../common/shellgame.nix # zsh config
  ];
}
