{ config, pkgs, ... }:

{
  #environment.systemPackages = with pkgs; [
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "Inconsolata" "Noto" "JetBrainsMono" "SourceCodePro" ]; })
    nerd-fonts.inconsolata
    nerd-fonts.noto
    nerd-fonts.jetbrains-mono
    nerd-fonts.sauce-code-pro
    font-awesome
    inconsolata
    inconsolata-nerdfont
    jetbrains-mono
    powerline
    ubuntu_font_family
    emacsPackages.nerd-icons
  ];
}
