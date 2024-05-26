{pkgs, ...}: {
  xdg.configFile."yazi/theme.toml".source =
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "yazi";
      rev = "0846aed69b2a62d29c98e100af0cf55ca729723d";
      sha256 = "2T41qWMe++3Qxl9veRNHMeRI3eU4+LAueKTss02gYNk=";
    }
    + "/themes/macchiato.toml";

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
