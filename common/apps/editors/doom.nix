{ pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/347752976096227aed7d06226e1045b5f0112386.tar.gz";
sha256 = "0prm07hjb78b43y9zp1ldd6yp1gncvff5w1mixys8njdbabhi5a1";
    }))
    (self: super: {
      doomEmacsBase = super.emacs-pgtk.override {
        withNativeCompilation = true;
        withTreeSitter = true;
        withXwidgets = true;
      };
    })
  ];

  #home.packages = with pkgs; [
  #  doomEmacsBase
  #];

  #services.emacs.package = pkgs.doomEmacsBase;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };
  services.emacs.enable = true;
}
