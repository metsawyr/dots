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
      postInstall = (old.postInstall or "") + ''
        cp ${./SystemStatsPanel.qml} $out/share/noctalia-shell/Modules/Panels/SystemStats/SystemStatsPanel.qml
      '';
    });
  };
}
