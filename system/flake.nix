{
	description = "config";

	inputs = {
	  nixpkgs.url = "nixpkgs/nixos-24.11";
	};

	outputs = { self, nixpkgs, ... }@inputs:
	  let
	    lib = nixpkgs.lib;
      system = "x86_64-linux";
	  in {
	  nixosConfigurations = {
	    nixos = lib.nixosSystem {
        specialArgs = { inherit inputs system; };
	      modules = [
	        ./configuration.nix
          ./sys
          ./hyprland
	      ];
	    };
	  };
   	};
}
