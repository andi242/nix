{
  description = "config";

  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-ust = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixvim = {
      url = "github:andi242/nixvim"; # private repo uses .ssh key
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lact-pr.url = "github:cything/nixpkgs?ref=lact";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim-loc = {
      url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/nixvim.git?shallow=1&ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-secrets = {
      url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/nixos-secrets.git?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, home-manager-ust, lact-pr, ... }:
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
          specialArgs = { inherit inputs system pkgs-unstable lact-pr; };
          modules = [
            ./hosts/pc
            # https://nixos-and-flakes.thiscute.world/nixpkgs/overlays
            (import ./overlays)
            home-manager.nixosModules.home-manager
            {
              # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager
              home-manager =
                {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "bak";
                  users.ad = import ./modules/home/home-pc.nix;
                  extraSpecialArgs = {
                    inherit inputs;
                    inherit pkgs-unstable;
                  };
                };
            }
          ];
        };
        ###########################################
        # macbook intel
        ###########################################
        nixos-mac = lib.nixosSystem {
          specialArgs = { inherit inputs system pkgs-unstable; };
          modules = [
            ./hosts/mac
            home-manager.nixosModules.home-manager
            {
              home-manager =
                {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "bak";
                  users.ad = import ./modules/home/home-mac.nix;
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
