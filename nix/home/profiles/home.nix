{pkgs, ...}: {
  # Standalone Hyprland desktop — personal subset, no work tooling.
  dev.desktop.hyprland.enable = true;

  home.packages = with pkgs; [
	unstable.claude-code
	mangohud
	protonup
	lutris
	bottles
  ];

  dev.langs = {
    go.enable = true;
    rust.enable = true;
    c.enable = true;
    nix.enable = true;
    lua.enable = true;
  };
}
