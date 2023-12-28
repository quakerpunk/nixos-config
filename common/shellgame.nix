{ config, pkgs, ... }:

{
  #zsh setup
  programs.zsh = {
    shellAliases = {
      #.. = "cd ..";
      h = "cd ~";
      ls = "eza --icons -l -T -L=1";
      cat = "bat";
      weather = "curl wttr.in/dallas";
    };
    enableAutosuggestions = true;
    enableCompletion = true;
    enable = true;
    syntaxHighlighting.enable = true;
  };

  #oh-my-zsh
  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
  };
}
