{
  pkgs,
  config,
  user,
  ...
}: {
  home.packages = with pkgs; [
    neovim
    vimPlugins.lazy-nvim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_LAZYNVIM = pkgs.vimPlugins.lazy-nvim;
  };

  xdg.configFile = with config.lib.file; {
    "nvim".source = mkOutOfStoreSymlink "/home/${user}/dots/neovim";
  };
}
