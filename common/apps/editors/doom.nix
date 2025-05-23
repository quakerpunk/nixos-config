{ pkgs, lib, ... }: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/347752976096227aed7d06226e1045b5f0112386.tar.gz";
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

  home.packages = with pkgs; [
    #  doomEmacsBase
    aspell
    aspellDicts.en
    pandoc
    vale
  ];

  #services.emacs.package = pkgs.doomEmacsBase;
  programs.emacs = {
    enable = true;
    #package = pkgs.emacs29-pgtk;
    package = (pkgs.emacs.override {
      withNativeCompilation = true;
      withTreeSitter = true;
      # withXwidgets = true;
      withGTK3 = true;
    });
    extraConfig = ''
      (setq ledger-binary-path "hledger")
      (setq ledger-default-date-string "%Y-%m-%d")
    '';
  };
  services.emacs.enable = true;
}
