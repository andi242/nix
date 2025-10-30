{ inputs ? false, home-manager ? false, ... }:
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
in rec {
  # Create a VM app from a nixos config
  mkVM = name: {
    type = "app";
    program = "${inputs.self.nixosConfigurations.${name}.config.system.build.vm}/bin/run-${
        inputs.self.nixosConfigurations.${name}.config.networking.hostName
      }-vm";
  };
  # make a function to avoid duplication
  mkSystem = { modules ? [ ./hosts/common.nix ], home-cfg ? false, username ? "ad" }:
    lib.nixosSystem {
      inherit pkgs;
      specialArgs = { inherit inputs system username; };
      modules = [
        # import all the OS modules
        # { imports = map (f: ./modules/${f}) (builtins.attrNames (builtins.readDir ./modules)); }
        (mkOpts ./modules "sysconf")
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
  # the most complicated crap to spare a few lines
  # generates config.options.optName from filenames in path
  # TODO template the lib.mkIf as well
  mkOpts = path: optName:
    let
      files = map (f: f) (builtins.attrNames (builtins.readDir path));
      filenames = map (a: lib.removeSuffix ".nix" a) files;
      # https://nix.dev/tutorials/module-system/a-basic-module/
    in {
      options.${optName} = builtins.listToAttrs (builtins.map (u: {
        name = u;
        value = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
      }) filenames);
      imports = map (f: path + "/${f}") files;
    };
}
