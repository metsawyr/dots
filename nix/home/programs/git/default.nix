{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.git;

    settings = {
      user.email = "metsawyr@gmail.com";
      user.name = "metsawyr";

      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
