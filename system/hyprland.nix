{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wayland
  ];

  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # Configure xwayland
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    #xkbOptions = "caps:escape";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
