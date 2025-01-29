{ config, pkgs, ...}:
let
  aliases = {
    vi = "nvim";
    d1 = "du -h -d1";
  };
in 
{
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
    
  }
}
