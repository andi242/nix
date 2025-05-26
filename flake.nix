{
  description = "config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stbl = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixvim = {
      url = "github:andi242/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lact-pr.url = "github:cything/nixpkgs?ref=lact";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # private repo uses .ssh key
    nixvim-loc = {
      url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/nixvim.git?shallow=1&ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-secrets = {
      url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/nixos-secrets.git?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, home-manager-stbl, lact-pr, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      #nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      nixvim = nixvim.legacyPackages.${system};
      # specialArgs = { inherit inputs; };
    in
    {
      nixosConfigurations = {
        nixos-pc = lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs system pkgs-stable lact-pr; };
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
                    inherit pkgs-stable;
                  };
                };
            }
          ];
        };
        ###########################################
        # macbook intel
        ###########################################
        nixos-mac = lib.nixosSystem {
          specialArgs = { inherit inputs system pkgs-stable; };
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
                    inherit pkgs-stable;
                  };
                };
            }
          ];
        };
      };
    };
}
