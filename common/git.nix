{ config, lib, pkgs, name, email, ... }:
{
  programs.git.enable = true;
  programs.git.userName = name;
  programs.git.userEmail = email;
}
