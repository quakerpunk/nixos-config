{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.opacity = lib.mkForce 0.55;
    window.padding.x = 15;
    window.padding.y = 15;
    font.normal.family = "JetBrains Mono";
    font.normal.style = "Regular";
  };
}
