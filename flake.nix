# combine home-manager and system flakes
{
  description = "combined config";

  outputs = { ... }:
    {
      # import ./home-manager;
      # import ./system;
      modules = [
        ./home-manager
        ./sys
      ];
    };
}
