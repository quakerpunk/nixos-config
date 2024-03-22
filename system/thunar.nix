{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
  ];

  programs.thunar.enable = true;
  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
}
