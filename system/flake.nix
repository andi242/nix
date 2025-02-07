{
  description = "config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      defaultModules = [ ./sys ];
    in
    {
      nixosConfigurations = {
        nixos-vm = lib.nixosSystem {
          specialArgs = { inherit inputs system pkgs-unstable; };
          modules = [
            ./vm-configuration.nix
            ./gnome
          ] ++ defaultModules;
        };
        nixos-mac = lib.nixosSystem {
          specialArgs = { inherit inputs system pkgs-unstable; };
          modules = [
            ./mac-configuration.nix
            ./gnome
          ] ++ defaultModules;
        };
        nixos-pc = lib.nixosSystem {
          specialArgs = { inherit inputs system pkgs-unstable; };
          modules = [
            ./pc-configuration.nix
            ./gnome
          ] ++ defaultModules;
        };

      };
    };
}
