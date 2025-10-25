{
  description = "config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # private repo uses .ssh key
    nix-secrets = {
      url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/nixos-secrets.git?shallow=1&ref=main";
      flake = false;
    };
    nix-dotfiles = {
      url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/dotfiles.git?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          # permittedInsecurePackages = [ ];
        };
      };
      # utility functions
      inherit (import ./utils.nix { inherit inputs system home-manager; }) mkAppVM mkSystem;
    in {
      # apps = rec {
      #   default = nixos-pc;
      #   # VM tests: `nix run .#apps.<name>`
      #   nixos-pc = mkAppVM "nixos-pc";
      # };
      nixosConfigurations = {
        nixos-pc = mkSystem {
          modules = [ ./hosts/pc (import ./overlays) ];
          home-cfg = ./home-pc.nix;
          # username = "ad";
        };
        # nixos-pc = lib.nixosSystem {
        #   inherit pkgs;
        #   specialArgs = { inherit inputs system; };
        #   modules = [
        #     ./modules.nix # import all the OS modules
        #     ./hosts/pc # activate OS modules here
        #     (import ./overlays)
        #     home-manager.nixosModules.home-manager
        #     {
        #       home-manager = {
        #         useGlobalPkgs = true;
        #         useUserPackages = true;
        #         backupFileExtension = "bak";
        #         users.ad = import ./home-pc.nix;
        #         extraSpecialArgs = { inherit inputs; };
        #       };
        #     }
        #   ];
        # };
      };
    };
}
