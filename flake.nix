{
  description = "Base flake for ShawnB's systems.";

  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-23.11";
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-generators, ... }@inputs:
    let
      name = "Shawn Borton";
      email = "shawn@shawnborton.info";
      system = "x86_64-linux";
      hostname = "peregrine";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        system = lib.nixosSystem {
          inherit system;
          modules = [ (./. + ("/"+hostname)+"/configuration.nix") ];
          specialArgs = {
            inherit hostname;
          };
        };
      };
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + ("/"+hostname)+"/home.nix") ];
          extraSpecialArgs = {
            inherit hostname;
            inherit name;
            inherit email;
          };
        };
    #};
      };
      packages.x86_64-linux = {
        lxc_test = nixos-generators.nixosGenerate {
          system = system;
          modules = [
            ./lxc_test/configuration.nix
          ];
         # modules = [ (./. + "/lxc-test/configuration.nix") ];
          format = "proxmox-lxc";
        };
      };
  };
}
