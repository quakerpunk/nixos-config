{ ... }:

{
  # import X11 config
  imports = [ ./x11.nix
              ./dbus.nix
              ../wm/fonts.nix
            ];

  # Setup XMonad
  services.displayManager = {
    # defaultSession = "none+qtile";
    defaultSession = "qtile";
  };
  services.xserver = {
    windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [
        (qtile-extras.overridePythonAttrs(
          old: { disabledTestPaths = [
              "test/widget/test_strava.py"
              "test/widget/test_image.py"
              "test/widget/test_upower.py"
              "test/widget/test_iwd.py"
             ];
          }))
      ]; 
    };
  };
}
