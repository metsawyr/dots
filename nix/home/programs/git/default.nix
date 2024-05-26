{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.git;

    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };

    userEmail = "metsawyr@gmail.com";
    userName = "metsawyr";

    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
