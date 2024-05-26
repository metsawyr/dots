{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";

    history = {
      size = 10000;
      save = 10000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    historySubstringSearch.enable = true;

    shellAliases = {
      g = "git";
      gl = "git pull";
      gp = "git push";
      gco = "git checkout";
      gst = "git status";
      gf = "git fetch";
      gr = "git rebase";
      ga = "git add";
      gaa = "git add -A";
      lg = "lazygit";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
    ];

    envExtra = ''
      export KEYTIMEOUT=1
         export PATH=$PATH:$HOME/.local/bin
    '';

    initExtra = ''
       function zle-keymap-select () {
      case $KEYMAP in
        vicmd) echo -ne '\e[1 q';; # block
        viins|main) echo -ne '\e[5 q';; # beam
      esac
       }

       zle -N zle-keymap-select

       zle-line-init() {
      zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
      echo -ne "\e[5 q"
       }

          zle -N zle-line-init
          echo -ne '\e[5 q' # Use beam shape cursor on startup.
       preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
    '';
  };
}
