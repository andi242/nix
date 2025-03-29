{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports =
    [
      # ./modules/system/vm # install os first, then copy hardware.nix , then uncomment!
      ./modules/system/gnome
      ./modules/system/macbook
      # or with --impure
      # /etc/nixos/hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_6_12; # 6.12 kernel
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=40s
  '';
  networking = {
    hostName = "nixos-mac";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      logRefusedConnections = false;
    };
  };
  users.users.ad.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPPWNYTLoJDX8GLkSlJQuvipNYlzdm4uyuZzWQPNZJ3HqvxLP9KSeecySzSrC3Srr5Guq9zGvYZLN/kZ9JFLYb83ZLoW8B6zOimWORNB1JLHMyNqoTCkaAJ2HdAJ9Uy4CS077uG1nJwd4cxvjIxOtFfPCZX8XX+CNNF0iusHA6PdKEN8JvTPkV85SDO+V9TWSUqXtMUNqPKVaYh3njlXE1S2rcBZYFTW2nuRXSOjzPrnRbSgFQUmR9o2ux7Y3yBsAp53Imi7bjVV4Borp5hkfdGW/tMN77LZA6I1RWaA8naxaUHxU+akryIeUiQ09esZsGaHagQXRX5TksITIq9R5gZ2GHgBS8QCWigMU58BERd/EhR7Egp1pYoXI2Lw5+MoDhpSY/R21a3tLOzGus5aiuvO8r/1Zgek+l2ZMQqKjXwulhJmRgq07vKYrLV/h0aWhN73OlouQ4/7L5XQBWgyTeeCzH4TPxQYpSlhKZZxyWAjVImnPIYO5SR1PIqi0sD1s= ad@pc-ad"
  ];
  time.timeZone = "Europe/Berlin";

  security.rtkit.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "24.11";
}
