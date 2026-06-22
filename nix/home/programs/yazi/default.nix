{pkgs, ...}: {
  # catppuccin/yazi ships a ready-to-use theme.toml per flavor/accent under
  # themes/<flavor>/. We use the macchiato "blue" accent to match the previous
  # theme. The old pinned rev used the legacy single-file format (`[manager]`,
  # `name =` rules) which newer yazi rejects, so this points at the current
  # repo layout that targets recent yazi releases.
  xdg.configFile."yazi/theme.toml".source =
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "yazi";
      rev = "baaf5d1c9427b836fbefd126aa855f9eab7a9d0d";
      sha256 = "1260viasyxmdldbpg2nwj7wmdb2rzi9v1i1rscj2829vrnj8191g";
    }
    + "/themes/macchiato/catppuccin-macchiato-blue.toml";

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";
  };
}
