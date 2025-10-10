{ pkgs, inputs, config, ... }:
{
  imports = [
    ./modules
  ];

  home = {
    username = "ad";
    homeDirectory = "/home/ad";
    stateVersion = "24.11";
    packages = with pkgs; [
      # inputs.nixvim.packages.${system}.default
      obsidian
      joplin-desktop
    ];
    # file = {
    #   ".config/nvim/snippets/nix.json".source = ./modules/misc/snippets-nix.json;
    # };
    sessionVariables = {
      # NH_FLAKE = "/home/ad/gits/nix";
      NIXOS_OZONE_WL = "1";
      GTK_THEME_VARIANT = "dark";
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
