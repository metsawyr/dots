{
  pkgs,
  config,
  user,
  ...
}: {
  home.packages = with pkgs; [
    neovim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.configFile = with config.lib.file; {
    "nvim".source = mkOutOfStoreSymlink "/home/${user}/dots/neovim";
  };
}
