{ inputs, system, home-manager, ... }:
let
  system = "x86_64-linux";
  lib = inputs.nixpkgs.lib;
  pkgs = import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      # permittedInsecurePackages = [ ];
    };
  };
in {
  # Create a VM app from a nixos config
  mkAppVM = name: {
    type = "app";
    program = "${inputs.self.nixosConfigurations.${name}.config.system.build.vm}/bin/run-nixos-vm";
  };

  mkSystem = { modules, home-cfg, username ? "ad" }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = { inherit inputs system; };
      modules = [
        ./modules.nix # import all the OS modules
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.${username} = import home-cfg;
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ] ++ modules;
    };
}
