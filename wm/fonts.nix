{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nerdfonts
    (nerdfonts.override { fonts = [ "Inconsolata" "Noto" "JetBrainsMono" ]; })
    font-awesome
    inconsolata
    inconsolata-nerdfont
    powerline
    ubuntu_font_family
  ];
}
