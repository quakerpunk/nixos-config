{ pkgs, ... }:

{
  imports = [ 
              ./dbus.nix
              ../wm/fonts.nix
            ];

  # Configure X11
  services.libinput = {
    touchpad.disableWhileTyping = true;
  };
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    #xkbOptions = "caps:escape";
    excludePackages = [ pkgs.xterm ];
    displayManager = {
      lightdm.enable = true;
      sessionCommands = ''
      xset -dpms
      xset s blank
      xset r rate 350 50
      xset s 300
      ${pkgs.lightlocker}/bin/light-locker --idle-hint &
    '';
    };
  };
}

