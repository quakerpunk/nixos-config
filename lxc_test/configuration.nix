{ config, pkgs, modulesPath, lib, system, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/profiles/minimal.nix")
  ];

  config = {
    #Provide a default hostname
    networking.hostName = lib.mkDefault "base";

    # Time Zone
    time.timeZone = "America/Chicago";

    # Enable QEMU Guest for Proxmox
    services.qemuGuest.enable = lib.mkDefault true;

    # Use the boot drive for grub
    boot.loader.grub.enable = lib.mkDefault true;
    boot.loader.grub.devices = [ "nodev" ];

    boot.growPartition = lib.mkDefault true;

    # Allow remote updates with flakes and non-root users
    nix.settings.trusted-users = [ "root" "@wheel" ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Some sane packages we need on every system
    environment.systemPackages = with pkgs; [
      vim # for emergencies
      git # for pulling nix flakes
      zsh
      bat
      eza
    ];

    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh = {
      shellAliases = {
        #.. = "cd ..";
        h = "cd ~";
        ls = "eza --icons -l -T -L=1";
        cat = "bat";
      };
      enable = lib.mkDefault true;
      autosuggestions.enable = lib.mkDefault true;
    };

    #oh-my-zsh
    programs.zsh.ohMyZsh = {
      enable = lib.mkDefault true;
      theme = lib.mkDefault "jtriley";
    };

    # Default filesystem
    fileSystems."/" = lib.mkDefault {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };

    system.stateVersion = lib.mkDefault "24.11";

    security.sudo.wheelNeedsPassword = false; # Don't ask for passwords
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      ports = [ 2112 ];
    };
    programs.ssh.startAgent = true;

    # Add an admin user
    users.users.shawnb = lib.mkDefault {
      isNormalUser = true;
      description = "Shawn Borton";
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILgyiCfvu21kVTfRyKjzpH+93k7Jsf+EqLfN6NtolHnf tech@shilohsvillage.com"
      ];
    };
  };
}
