{ ... }:

{
  # import X11 config
  imports = [ ./x11.nix
              ./dbus.nix
              ../wm/fonts.nix
            ];

  # Setup XMonad
  services.xserver = {
    windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [
        (qtile-extras.overridePythonAttrs(old: { disabledTestPaths = [ "test/widget/test_strava.py" ]; }))
      ]; 
    };
    displayManager = {
      defaultSession = "none+qtile";
    };
  };
}
