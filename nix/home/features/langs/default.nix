{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.dev.langs;
  inherit (lib) mkEnableOption mkIf mkMerge;
in {
  options.dev.langs = {
    go.enable = mkEnableOption "Go toolchain";
    rust.enable = mkEnableOption "Rust toolchain";
    node.enable = mkEnableOption "Node/TS toolchain";
    c.enable = mkEnableOption "C toolchain";
    erlang.enable = mkEnableOption "Erlang toolchain";
    lua.enable = mkEnableOption "Lua toolchain";
    nix.enable = mkEnableOption "Nix tooling";
    protobuf.enable = mkEnableOption "Protobuf tooling";
  };

  config = mkMerge [
    (mkIf cfg.go.enable {
      home.packages = with pkgs; [
        go
        gopls
        golangci-lint
        golangci-lint-langserver
        golines
        gotests
        delve
      ];
    })
    (mkIf cfg.rust.enable {
      home.packages = with pkgs; [rustup];
    })
    (mkIf cfg.node.enable {
      home.packages = with pkgs; [
        bun
        nodePackages.typescript-language-server
        nodePackages.prettier
      ];
    })
    (mkIf cfg.c.enable {
      home.packages = with pkgs; [gcc ccls];
    })
    (mkIf cfg.erlang.enable {
      home.packages = with pkgs; [erlang erlang-language-platform];
    })
    (mkIf cfg.lua.enable {
      home.packages = with pkgs; [lua-language-server];
    })
    (mkIf cfg.nix.enable {
      home.packages = with pkgs; [nil];
    })
    (mkIf cfg.protobuf.enable {
      home.packages = with pkgs; [buf];
    })
  ];
}
