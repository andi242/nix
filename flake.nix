{
	description = "config";

	inputs = {
	  nixpkgs.url = "nixpkgs/nixos-24.11";
	};

	outputs = { self, nixpkgs, ... }:
	  let
	    lib = nixpkgs.lib;
	  in {
	  nixosConfigurations = {
	    nixos = lib.nixosSystem {
	      system = "x86_64-linux";
	      modules = [
	        ./configuration.nix
          ./modules/zsh
          ./modules/starship
          ./modules/sys
          ./modules/hyprland
	      ];
	    };
	  };
	};
}
