{
  description = "Home Manager configuration of ad";
  # https://gist.github.com/siph/288b7c6b5f68a1902d28aebc95fde4c5
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:andi242/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      nixvim = nixvim.legacyPackages.${system};
    in
    {
      homeConfigurations."ad" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
            inherit inputs;
        };
        modules = [
          ./home.nix
          ./modules/gnome
        ];
      };
      # homeConfigurations."ad-hl" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   modules = [ 
      #     ./home.nix
      #     ./modules/hyprland
      #     ./modules/zsh
      #     ./modules/starship
      #   ];
      #   # extraSpecialArgs = { inherit nix-colors; };
      # };

    };
}
