{ config, pkgs, lib, inputs, ... }:

let
  user = "ad";
  interface = "wlan0";
  hostname = "nixos-pi1";
  aliases = {
    cat = "bat -pp";
    dff = "${pkgs.duf}/bin/duf --hide-fs tmpfs,devtmpfs,efivarfs --hide-mp '/nix/store' --output mountpoint,avail,used,usage --theme ansi";
  };
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ./secrets/pc.yaml;
    defaultSopsFormat = "yaml";
    age = {
      # first get with ssh-keyscan, then automatically use this
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # path of keys
      keyFile = "/root/.config/sops/age/keys.txt";
      # generate if not exists
      generateKey = true;
    };
  };
  sops.secrets = {
    wifi_file = { };
    user_1 = {
      owner = config.users.users.ad.name;
      neededForUsers = true;
    };
  };
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = hostname;
    wireless = {
      enable = true;
      secretsFile = config.sops.secrets.wifi_file.path;
      networks = {
        home.pskRaw = "ext:psk_home";
        home.auth = ''
          password=ext:pass_home
        '';
      };
      interfaces = [ interface ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    nh # nix helper
    nix-output-monitor # for nh
    nvd # for nh
    btop
    unzip
    duf
    bat
    starship
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs = {
    zsh = {
      enable = true;
      shellAliases = aliases;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions = {
        enable = true;
        strategy = [ "history" ];
      };
    };
  };
  programs.starship = {
    enable = true;
  };

  services.openssh.enable = true;

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.user_1.path;
      extraGroups = [ "wheel" ];
    };
  };
  security.sudo.extraRules = [
    { groups = [ "wheel" ]; commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }]; }
  ];
  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "25.05";
}
