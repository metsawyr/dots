{pkgs, ...}: let
  catppuccinYazi = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "0846aed69b2a62d29c98e100af0cf55ca729723d";
    sha256 = "2T41qWMe++3Qxl9veRNHMeRI3eU4+LAueKTss02gYNk=";
  };
  # Newer yazi renamed the `[filetype]` rule key `name` to `url`; this pinned
  # catppuccin theme predates that change, so patch it to avoid the
  # "at least one of `url` or `mime` must be specified" TOML parse error.
  yaziTheme =
    builtins.replaceStrings ["name ="] ["url ="]
    (builtins.readFile (catppuccinYazi + "/themes/macchiato.toml"));
in {
  xdg.configFile."yazi/theme.toml".text = yaziTheme;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";
  };
}
