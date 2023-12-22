{
  description = "Base flake for ShawnB's systems.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
  };
}
