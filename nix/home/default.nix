{
  pkgs,
  inputs,
  user,
  ...
}: let
  tools = with pkgs; [
    code-minimap
    curl
	fastfetch
    fd
    git
    gh
	gnumake
    htop
    jq
    nh
    pinentry-curses
    ripgrep
    tree-sitter
    unzip
    wget
    zip

    # Editor LSPs paired with neovim
    yaml-language-server
  ];
in {
  home = {
    stateVersion = "24.05";

    packages = tools;
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
      NH_FLAKE = "/home/${user}/dots/nix";
    };
  };

  imports =
    [inputs.nix-colors.homeManagerModules.default]
    ++ import ./programs
    ++ [
      ./features/langs
      ./features/tools
      ./features/desktop
    ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

  programs.home-manager = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
