{lib, ...}: {
  options.dev.desktop.hyprland.enable =
    lib.mkEnableOption "Hyprland desktop environment";

  imports = [
    ./hyprland.nix
    ./noctalia.nix
  ];
}
