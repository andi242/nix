{ pkgs, inputs, config, ... }:
{
  imports = [
    ./modules
  ];

  home = {
    username = "ad";
    homeDirectory = "/home/ad";
    stateVersion = "24.05";
    packages = with pkgs; [
      inputs.nixvim.packages.${system}.default
    ];
    file = {
      ".config/nvim/snippets/nix.json".source = ./modules/user/misc/snippets-nix.json;
    };
    sessionVariables = {
      FLAKE = "/home/ad/gits/nix";
      NIXOS_OZONE_WL = "1";
      GTK_THEME_VARIANT = "dark";
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
