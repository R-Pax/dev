
{
  description = "NixOS on M4 Mac mini using the Gravity 16K kernel";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Use the Mesa version from Gravity Linux for proper M4 graphics support.
    firn = {
      url = "github:Youwes09/Firn/28da0767905094c9daa1bceeedbbf14a1161702a";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos-m4 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./user.nix
          home-manager.nixosModules.default

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.pax = import ./home;
          }
        ];
      };

      packages.${system}.nixos-install-tools = pkgs.nixos-install-tools;
    };
}

