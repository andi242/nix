{ pkgs, inputs, ... }:
{
  services.clamav = {
    updater.enable = true;
    daemon.enable = true;
  };
  environment.systemPackages = with pkgs; [
    clamav
  ];
}
