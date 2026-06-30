{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
lib.mkIf config.dev.desktop.hyprland.enable {
  programs.noctalia-shell = {
    enable = true;
    package = (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default).overrideAttrs (old: {
      patches = (old.patches or []) ++ [ ./system-stats-panel-disk-paths.patch ];
    });
  };
}
