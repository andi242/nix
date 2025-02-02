{
	description = "config";

	inputs = {
	  nixpkgs.url = "nixpkgs/nixos-24.11";
	};

	outputs = { self, nixpkgs, ... }@inputs:
	  let
	    lib = nixpkgs.lib;
      system = "x86_64-linux";
      defaultModules = [ ./sys ./hyprland ];
	  in {
	    nixosConfigurations = {
  	    nixos-vm = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
	        modules = [
	          ./vm-configuration.nix
	        ] ++ defaultModules ;
	      };
  	    nixos-mac = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
	        modules = [
	          ./mac-configuration.nix
	        ] ++ defaultModules;
	      };
	    };
    };
}
