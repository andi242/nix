{ inputs, config, pkgs, ...}:
let
  aliases = {
    vi = "nvim";
    d1 = "du -h -d1";
    rebuild = "sudo nixos-rebuild switch --flake .";
    ngc = "nix-env --delete-generations old";
    cleanup = "nix-store --gc";
  };
in 
{
  programs.git = {
    userName = "andi242";
    userEmail = "andi242@gmail.com";
  };
  programs.zsh = {
    enable = true;
    shellAliases = aliases;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    historySubstringSearch = {
      enable = false;
    };
    initExtra = ''
      if [ $commands[starship] ]; then
        echo "starship init"
        eval "$(starship init zsh)"
      fi
    '';
    
  };
}
