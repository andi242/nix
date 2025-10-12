let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
  nix-maid = import sources.nix-maid;
in nix-maid pkgs {
  file.xdg_config."nvim/".source = "{{home}}/gits/dotfiles/nvim/";
}
