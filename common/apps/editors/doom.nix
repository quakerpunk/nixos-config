{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
    (self: super: {
      doomEmacsBase = super.emacsGit.override {
        withGTK3 = true;
        withNativeCompilation = true;
        withTreeSitter = true;
        withXwidgets = true;
      };
    })
  ];

  home.packages = with pkgs; [
    doomEmacsBase
  ];

  services.emacs.package = pkgs.doomEmacsBase;
  services.emacs.enable = true;
}
