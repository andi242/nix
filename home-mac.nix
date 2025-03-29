{ pkgs, inputs, config, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];
  users.users.ad.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPPWNYTLoJDX8GLkSlJQuvipNYlzdm4uyuZzWQPNZJ3HqvxLP9KSeecySzSrC3Srr5Guq9zGvYZLN/kZ9JFLYb83ZLoW8B6zOimWORNB1JLHMyNqoTCkaAJ2HdAJ9Uy4CS077uG1nJwd4cxvjIxOtFfPCZX8XX+CNNF0iusHA6PdKEN8JvTPkV85SDO+V9TWSUqXtMUNqPKVaYh3njlXE1S2rcBZYFTW2nuRXSOjzPrnRbSgFQUmR9o2ux7Y3yBsAp53Imi7bjVV4Borp5hkfdGW/tMN77LZA6I1RWaA8naxaUHxU+akryIeUiQ09esZsGaHagQXRX5TksITIq9R5gZ2GHgBS8QCWigMU58BERd/EhR7Egp1pYoXI2Lw5+MoDhpSY/R21a3tLOzGus5aiuvO8r/1Zgek+l2ZMQqKjXwulhJmRgq07vKYrLV/h0aWhN73OlouQ4/7L5XQBWgyTeeCzH4TPxQYpSlhKZZxyWAjVImnPIYO5SR1PIqi0sD1s= ad@pc-ad"
  ];
  userconf = {
    obs.enable = false;
    zellij.enable = false;
    # userPkgs = with pkgs; [
    #   nh # nix helper
    #   nix-output-monitor # for nh
    #   nvd # for nh
    #   geist-font
    #   kitty
    #   zsh
    # ];
  };
}
