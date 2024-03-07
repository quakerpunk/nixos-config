{ config, pkgs, ... }:

{
  #environment.systemPackages = with pkgs; [
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Inconsolata" "Noto" "JetBrainsMono" "SourceCodePro" ]; })
    font-awesome
    inconsolata
    inconsolata-nerdfont
    jetbrains-mono
    powerline
    ubuntu_font_family
  ];
}
