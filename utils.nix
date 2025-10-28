{ inputs, home-manager, ... }:
let
  # hostname = inherit (config.networking) hostName;
  system = "x86_64-linux";
  lib = inputs.nixpkgs.lib;
  # hostname = (nixos-system configuration).config.networking.hostName;
  pkgs = import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      # permittedInsecurePackages = [ ];
    };
  };
in {
  # Create a VM app from a nixos config
  mkVM = name: {
    type = "app";
    program = "${inputs.self.nixosConfigurations.${name}.config.system.build.vm}/bin/run-${inputs.self.nixosConfigurations.${name}.config.networking.hostName}-vm";
  };
  # make a function to avoid duplication
  mkSystem = { modules ? [ ./hosts/common.nix ], home-cfg ? false, username ? "ad" }:
    lib.nixosSystem {
      inherit pkgs;
      specialArgs = { inherit inputs system username; };
      modules = [
        # import all the OS modules
        ./modules.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            # if this is false HM will skip completely
            users = lib.mkIf (builtins.isPath home-cfg) { ${username} = (import home-cfg { inherit username; }); };
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ] ++ modules;
    };
}
