{ pkgs, ... }:
let
  aliases = {
    cat = "bat --paging=never";
  };
in
{
  # some config
  nixpkgs.config.allowUnfree = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
  };
  services.flatpak.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
    unzip
    podman
    fontconfig
    git
    wget
    fzf
    # nix helpers
    nh
    nix-output-monitor # for nh
    nvd # for nh

    curl
    unzip
    zsh
    starship
    home-manager
    gcc
    bat
    bitwarden-cli
    openssl
    neovim
    lazygit
    kubectl
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "GeistMono" ]; })
    # in nixos-unstable/25.05:
    # nerd-fonts.geist-mono
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  imports = [
  ];
  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
  };
  security.sudo.extraRules = [
    { groups = [ "wheel" ]; commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }]; }
  ];
}
