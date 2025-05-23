{ config, pkgs, ... }:

{
  #environment.systemPackages = with pkgs; [
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "Inconsolata" "Noto" "JetBrainsMono" "SourceCodePro" ]; })
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    nerd-fonts.overpass
    nerd-fonts.sauce-code-pro
    font-awesome
    inconsolata
    jetbrains-mono
    overpass
    powerline
    ubuntu_font_family
    emacsPackages.nerd-icons
  ];
}
