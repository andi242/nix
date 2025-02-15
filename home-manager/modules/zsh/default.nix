{ inputs, config, pkgs, ... }:
let
  aliases = {
    d1 = "du -h -d1";
    ll = "ls -lah";
    gd = "git diff";
    gs = "git status";
    grep = "grep --color";
    mkdir = "mkdir -p";
  };
in
{
  imports = [ ./zellij.nix ];
  programs.git = {
    enable = true;
    userName = "andi242";
    userEmail = "andi242@gmail.com";
  };
  programs.zsh = {
    enable = true;
    shellAliases = aliases;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    historySubstringSearch = {
      enable = true;
    };
    initExtra = ''
      function gall(){
        echo "commit message: ''${@}"
        git pull && git add --all && git commit -m ''${@} && git push && git log --oneline --decorate -n5
      }
      # Use emacs key bindings
      bindkey -e
      # Start typing + [Up-Arrow] - fuzzy find history forward
      if [[ -n "''${terminfo[kcuu1]}" ]]; then
        autoload -U up-line-or-beginning-search
        zle -N up-line-or-beginning-search

        bindkey -M emacs "''${terminfo[kcuu1]}" up-line-or-beginning-search
        bindkey -M viins "''${terminfo[kcuu1]}" up-line-or-beginning-search
        bindkey -M vicmd "''${terminfo[kcuu1]}" up-line-or-beginning-search
      fi
      # Start typing + [Down-Arrow] - fuzzy find history backward
      if [[ -n "''${terminfo[kcud1]}" ]]; then
        autoload -U down-line-or-beginning-search
        zle -N down-line-or-beginning-search

        bindkey -M emacs "''${terminfo[kcud1]}" down-line-or-beginning-search
        bindkey -M viins "''${terminfo[kcud1]}" down-line-or-beginning-search
        bindkey -M vicmd "''${terminfo[kcud1]}" down-line-or-beginning-search
      fi

      # [Home] - Go to beginning of line
      if [[ -n "''${terminfo[khome]}" ]]; then
        bindkey -M emacs "''${terminfo[khome]}" beginning-of-line
        bindkey -M viins "''${terminfo[khome]}" beginning-of-line
        bindkey -M vicmd "''${terminfo[khome]}" beginning-of-line
      fi
      # [End] - Go to end of line
      if [[ -n "''${terminfo[kend]}" ]]; then
        bindkey -M emacs "''${terminfo[kend]}"  end-of-line
        bindkey -M viins "''${terminfo[kend]}"  end-of-line
        bindkey -M vicmd "''${terminfo[kend]}"  end-of-line
      fi

      # [Backspace] - delete backward
      bindkey -M emacs '^?' backward-delete-char
      bindkey -M viins '^?' backward-delete-char
      bindkey -M vicmd '^?' backward-delete-char
      # [Delete] - delete forward
      if [[ -n "''${terminfo[kdch1]}" ]]; then
        bindkey -M emacs "''${terminfo[kdch1]}" delete-char
        bindkey -M viins "''${terminfo[kdch1]}" delete-char
        bindkey -M vicmd "''${terminfo[kdch1]}" delete-char
      else
        bindkey -M emacs "^[[3~" delete-char
        bindkey -M viins "^[[3~" delete-char
        bindkey -M vicmd "^[[3~" delete-char

        bindkey -M emacs "^[3;5~" delete-char
        bindkey -M viins "^[3;5~" delete-char
        bindkey -M vicmd "^[3;5~" delete-char
      fi
      setopt HIST_FCNTL_LOCK
      unsetopt APPEND_HISTORY
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_SPACE
      unsetopt HIST_EXPIRE_DUPS_FIRST
      setopt SHARE_HISTORY
      unsetopt EXTENDED_HISTORY
      if [ $commands[nh] ]; then
        echo "nh init"
        eval "$(nh completions --shell=zsh)"
      fi
    '';
  };
}
