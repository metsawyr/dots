{pkgs, ...}: {
  # Standalone Hyprland desktop — personal subset, no work tooling.
  dev.desktop.hyprland.enable = true;

  home.packages = [pkgs.unstable.claude-code];

  dev.langs = {
    go.enable = true;
    rust.enable = true;
    nix.enable = true;
    lua.enable = true;
  };
}
