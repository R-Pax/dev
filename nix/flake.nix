{
  description = "NixOS on M4 Mac mini using the Gravity 16K kernel";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Use the Mesa version from Gravity Linux for proper M4 graphics support.v
    firn = {
      url = "github:Youwes09/Firn/28da0767905094c9daa1bceeedbbf14a1161702a";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
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
        ];
      };

      packages.${system}.nixos-install-tools = pkgs.nixos-install-tools;
    };
}

