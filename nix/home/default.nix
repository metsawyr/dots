{
  pkgs,
  inputs,
  user,
  ...
}: let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
    kubectl
  ]);

  tools = with pkgs; [
    code-minimap
    curl
    fd
    fluxcd
    git
    gh
    htop
    jq
    minikube
	mise
    neofetch
    nh
    pinentry
    ripgrep
    tree-sitter
    unzip
    wget
    zip
    gcloud
  ];

  langs = with pkgs; [
  	delve
    # Rust
    rustup

    # Protobuf
    buf

    # C
    gcc
    ccls

	# Erlang
	erlang
	erlang-language-platform

    # NodeJS
    bun
    nodePackages.typescript-language-server
    nodePackages.prettier

    # Lua
    lua-language-server

    # Nix
    nil

    # Other
    yaml-language-server
    vscode-langservers-extracted # html, css, json, eslint
  ];
in {
  home = {
    stateVersion = "24.05";

    packages = tools ++ langs;
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
      FLAKE = "/home/${user}/dots/nix";
    };
  };

  home.file.".local/bin/bazel_gopackagesdriver.sh" = {
    source = ./shell/bazel_gopackagesdriver.sh;
    executable = true;
  };

  imports = [inputs.nix-colors.homeManagerModules.default] ++ import ./programs;

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
    enableAliases = true;
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
