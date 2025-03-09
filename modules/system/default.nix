{ pkgs, inputs, ... }:
let
  aliases = {
    cat = "bat --paging=never";
  };
in
{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs = {
    zsh = {
      enable = true;
      shellAliases = aliases;
    };
  };
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # system packages
  environment.systemPackages = with pkgs; [
    unzip
    podman
    fontconfig
    git
    wget
    fzf
    tree
    nh # nix helper
    nix-output-monitor # for nh
    nvd # for nh
    curl
    unzip
    zsh
    starship
    home-manager
    gcc
    bat
    openssl
    neovim
    lazygit
    kubectl
    usbutils
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "GeistMono" ]; })
    # in nixos-unstable/25.05:
    # nerd-fonts.geist-mono
  ];

  imports = [
    # ./fprint.nix
  ];
  # garbage collection
  # nix.gc = {
  #   automatic = true;
  #   dates = "daily";
  #   options = "--delete-older-than 10d";
  # };

  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
  };

  security.sudo.extraRules = [
    { groups = [ "wheel" ]; commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }]; }
  ];
}
