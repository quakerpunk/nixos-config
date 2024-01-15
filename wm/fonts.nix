{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (nerdfonts.override { fonts = [ "Inconsolata" ]; })
    font-awesome
    inconsolata
    inconsolata-nerdfont
    jetbrains-mono
    powerline
    ubuntu_font_family
  ];
}
