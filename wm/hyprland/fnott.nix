{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    fnott
  ];

  services.fnott = {
    enable = true;
    settings = {
      main = {
        anchor = "top-right";
        background = "3f5f3fff";
        border-color = "909090ff";
        body-font = "sans serif";
        body-color = "ffffffff";
        body-format  = " %b";
        border-size = 0;
        min-width = 300;
        stacking-order = "bottom-up";
        summary-font = "sans serif";
        summary-color = "ffffffff";
        summary-format = "<b>%s</b>\n";
        title-font = "sans serif";
        title-color = "ffffffff";
        title-format = "<i>%a%A</i>";
      };
    };
  };
}
