{pkgs, ...}: {
  xdg.configFile."k9s/skins/catppuccin-macchiato.yaml".source =
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "k9s";
      rev = "4432383da214face855a873d61d2aa914084ffa2";
      sha256 = "GFWOldDhpn98X9eEaMVjhZtGDKxNukmSR2EZqAAOH6o=";
    }
    + "/dist/catppuccin-macchiato.yaml";

  programs.k9s = {
    enable = true;
    settings.k9s = {
      ui = {
        enableMouse = true;
        skin = "catppuccin-macchiato";
      };
    };
  };
}
