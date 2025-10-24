{
  nix.optimise = {
    automatic = true;
    dates = [ "Mon *-*-* 00:00:00" ];
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
