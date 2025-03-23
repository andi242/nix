{ pkgs, inputs, pkgs-unstable, ... }:
let
  aliases = {
    cat = "bat -pp";
    dff = "${pkgs.duf}/bin/duf --hide-fs tmpfs,devtmpfs,efivarfs --hide-mp '/nix/store' --output mountpoint,avail,used,usage --theme ansi";
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
  services.journald.extraConfig = ''
    SystemMaxUse=300M
  '';
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # system packages
  documentation.doc.enable = false; # no html docs
  environment.systemPackages = (with pkgs; [
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
    duf # du in nice
    curl
    zsh
    starship
    home-manager
    gcc
    bat
    openssl
    neovim
    nfs-utils
    lazygit
    kubectl
    usbutils
  ]) ++
  (with pkgs-unstable;
  [
    # add
  ]);

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
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "7d" ];
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
