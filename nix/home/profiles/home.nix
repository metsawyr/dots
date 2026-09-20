{pkgs, ...}: let
  # Not packaged in nixpkgs' vscode-extensions set; pulled from the marketplace.
  ccls = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "ccls-project";
      name = "ccls";
      version = "0.1.30";
      hash = "sha256-OALPrPboOyvy5JqdGKvH5mEkY8N07S/k2r37Eh86otI=";
    };
  };
in {
  # Standalone Hyprland desktop — personal subset, no work tooling.
  dev.desktop.hyprland.enable = true;

  home.packages = with pkgs; [
	unstable.claude-code
	mangohud
	protonup-ng
	lutris
	bottles
	remmina
	ardour
	gdb
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = [
        ccls
        pkgs.vscode-extensions.catppuccin.catppuccin-vsc
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "ccls.launch.command" = "${pkgs.ccls}/bin/ccls";
      };
    };
  };

  dev.langs = {
    go.enable = true;
    rust.enable = true;
    c.enable = true;
    nix.enable = true;
    lua.enable = true;
  };
}
