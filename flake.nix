{
  description = "config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:andi242/nixvim"; # private repo uses .ssh key
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      nixvim = nixvim.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos-pc = lib.nixosSystem {
          specialArgs = { inherit inputs system pkgs-unstable; };
          modules = [
            ./configuration.nix
            ./modules/system
            home-manager.nixosModules.home-manager
            {
              # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager
              home-manager =
                {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.ad = import ./home.nix;
                  extraSpecialArgs = {
                    inherit inputs;
                    inherit pkgs-unstable;
                  };
                };
            }
          ];
        };
      };
    };
}
