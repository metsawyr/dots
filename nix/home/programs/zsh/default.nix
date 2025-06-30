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
	  export PATH=$PATH:$HOME/.local/mise/bin

		export MISE_SHELL=zsh
		export __MISE_ORIG_PATH="$PATH"

		mise() {
		  local command
		  command="$${1:-}"
		  if [ "$#" = 0 ]; then
			command mise
			return
		  fi
		  shift

		  case "$command" in
		  deactivate|shell|sh)
			# if argv doesn't contains -h,--help
			if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
			  eval "$(command mise "$command" "$@")"
			  return $?
			fi
			;;
		  esac
		  command mise "$command" "$@"
		}

		_mise_hook() {
		  eval "$(mise hook-env -s zsh)";
		}
		typeset -ag precmd_functions;
		if [[ -z "$${precmd_functions[(r)_mise_hook]+1}" ]]; then
		  precmd_functions=( _mise_hook $${precmd_functions[@]} )
		fi
		typeset -ag chpwd_functions;
		if [[ -z "$${chpwd_functions[(r)_mise_hook]+1}" ]]; then
		  chpwd_functions=( _mise_hook $${chpwd_functions[@]} )
		fi

		_mise_hook
		if [ -z "$${_mise_cmd_not_found:-}" ]; then
			_mise_cmd_not_found=1
			[ -n "$(declare -f command_not_found_handler)" ] && eval "$${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

			function command_not_found_handler() {
				if [[ "$1" != "mise" && "$1" != "mise-"* ]] && mise hook-not-found -s zsh -- "$1"; then
				  _mise_hook
				  "$@"
				elif [ -n "$(declare -f _command_not_found_handler)" ]; then
					_command_not_found_handler "$@"
				else
					echo "zsh: command not found: $1" >&2
					return 127
				fi
			}
		fi
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
