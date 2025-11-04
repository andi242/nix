{
  description = "config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # currently not used
    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    #
    # # private repo uses .ssh key
    # nix-secrets = {
    #   url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/nixos-secrets.git?shallow=1&ref=main";
    #   flake = false;
    # };
    nix-dotfiles = {
      # points to 10.1.1.100 to spare the research. :p
      url = "git+ssh://forgejo@git.andi242.dedyn.io:2222/ad/dotfiles.git?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      # utility functions
      # let's rework again https://github.com/LuNeder/nixos-config/blob/strawberry/flake.nix
      inherit (import ./utils.nix { inherit inputs home-manager; }) mkVM mkSystem;
    in {
      apps."x86_64-linux" = rec {
        default = nixos-pc;
        # VM tests: `nix run .#<name>`
        nixos-pc = mkVM "nixos-pc";
        mini = mkVM "mini";
      };
      nixosConfigurations = {
        nixos-pc = mkSystem { modules = [ ./hosts/pc (import ./overlays) ]; };
        mini = mkSystem { modules = [ ./hosts/mini ]; };
        mac = mkSystem { modules = [ ./hosts/mac ]; };
      };
    };
}
