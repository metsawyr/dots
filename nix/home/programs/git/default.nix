{pkgs, ...}: let
  catppuccinDelta = pkgs.writeText "catppuccin-delta.gitconfig" ''
    [catppuccin-macchiato]
        blame-palette = "#24273a" "#1e2030" "#212337" "#2d3144" "#363a4f"
        commit-decoration-style = box ul
        dark = true
        file-decoration-style = "#8aadf4"
        file-style = "#8aadf4"
        hunk-header-decoration-style = "#24273a" box ul
        hunk-header-file-style = bold
        hunk-header-line-number-style = bold "#a5adcb"
        hunk-header-style = file line-number syntax
        line-numbers-left-style = "#363a4f"
        line-numbers-minus-style = bold "#ed8796"
        line-numbers-plus-style = bold "#a6da95"
        line-numbers-right-style = "#363a4f"
        line-numbers-zero-style = "#a5adcb"
        minus-emph-style = bold syntax "#52252b"
        minus-style = syntax "#3a2230"
        plus-emph-style = bold syntax "#1e4423"
        plus-style = syntax "#283a2c"
  '';
in {
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

    includes = [{path = "${catppuccinDelta}";}];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "catppuccin-macchiato";
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        activeBorderColor = ["#a6da95" "bold"];
        inactiveBorderColor = ["#cad3f5"];
        searchingActiveBorderColor = ["#eed49f" "bold"];
        optionsTextColor = ["#8aadf4"];
        selectedLineBgColor = ["#363a4f"];
        cherryPickedCommitBgColor = ["#494d64"];
        cherryPickedCommitFgColor = ["#c6a0f6"];
        unstagedChangesColor = ["#ed8796"];
        defaultFgColor = ["#cad3f5"];
        selectedRangeBgColor = ["#363a4f"];
      };
    };
  };
}
