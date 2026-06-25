{
  lib,
  config,
  ...
}:
lib.mkIf config.dev.desktop.hyprland.enable {
  programs.noctalia-shell.enable = true;
}
