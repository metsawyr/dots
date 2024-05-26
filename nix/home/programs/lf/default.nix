{
  config,
  inputs,
  pkgs,
  ...
}: let
  color = with inputs.nix-colors;
    base: lib.conversions.hexToRGBString ";" config.colorScheme.palette."base${base}";

  foreground = hexcolor: "38;2;${color hexcolor}";

  lfxTempFile = "/tmp/lfx_cwd_on_quit";
in {
  programs.zsh.shellAliases.lf = "lfx";
  programs.zsh.initExtra = ''
       lfx() {
      tmp="${lfxTempFile}"
      ${pkgs.lf}/bin/lf "$@"
      if [ -f "$tmp" ]; then
           dir="$(cat $tmp)"
    	rm -f $tmp
     	if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
     	  cd "$dir"
        fi
      fi
    }
  '';
  programs.lf = {
    enable = true;

    settings = {
      icons = true;
      preview = true;
      dirpreviews = true;
      number = true;
      relativenumber = true;
      ratios = "2:3:2";
      drawbox = true;
      ignorecase = true;
      cursoractivefmt = "\\033[${foreground "01"}m\\033[48;2;${color "0B"}m";
      cursorpreviewfmt = "\\033[48;2;${color "02"}m";
    };

    commands = {
      mkdir = ''        ''${{
        		printf "Directory name: "
        		read dir
        		mkdir $dir
        	  }}'';
      touch = ''        ''${{
        	    printf "File name: "
        		read file
        		touch $file
        	  }}'';
      rename = ''        ''${{
        	  	printf "New name: "
        		read name
        		mv $f $name
        	  }}'';
      edit = ''$$EDITOR $f'';
      quit-cd = ''        ''${{
        		tmp="${lfxTempFile}"
        		echo "$PWD" > $tmp
        		lf -remote "send $id quit"
        	  }}'';
    };

    keybindings = {
      w = "";
      wq = "quit-cd";
      md = "mkdir";
      mf = "touch";
      r = "rename";
      e = "edit";
      "." = "set hidden!";
    };
  };

  xdg.configFile."lf/icons".source = ./icons;
  xdg.configFile."lf/colors".text = ''
    ln      ${foreground "0C"};01   # LINK
    or      ${foreground "08"};01   # ORPHAN
    tw      ${foreground "0D"}      # STICKY_OTHER_WRITABLE
    ow      ${foreground "0D"}      # OTHER_WRITABLE
    st      ${foreground "0D"};01   # STICKY
    di      ${foreground "0D"};01   # DIR
    pi      ${foreground "0A"}      # FIFO
    so      ${foreground "0E"}      # SOCK
    bd      ${foreground "0A"};01   # BLK
    cd      ${foreground "0A"};01   # CHR
    su      ${foreground "0D"};01   # SETUID
    sg      ${foreground "0D"};01   # SETGID
    ex      ${foreground "0D"};01   # EXEC
    fi      ${foreground "05"}      # FILE
  '';
}
