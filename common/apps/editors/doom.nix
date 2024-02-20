{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/347752976096227aed7d06226e1045b5f0112386.tar.gz;
      sha256 = 347752976096227aed7d06226e1045b5f0112386;
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
