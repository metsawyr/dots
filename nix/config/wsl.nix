{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [inputs.nixos-wsl.nixosModules.wsl];

  environment.systemPackages = [
    (import ./win32yank.nix {inherit pkgs;})
  ];

  wsl = {
    enable = true;
    defaultUser = user;
  };

  # solution adapted from: https://github.com/K900/vscode-remote-workaround
  # more information: https://github.com/nix-community/NixOS-WSL/issues/238 and https://github.com/nix-community/NixOS-WSL/issues/294
  systemd.user = {
    paths.vscode-remote-workaround = {
      wantedBy = ["default.target"];
      pathConfig.PathChanged = "%h/.vscode-server/bin";
    };
    services.vscode-remote-workaround.script = ''
      for i in ~/.vscode-server/bin/*; do
        echo "Fixing vscode-server in $i..."
        ln -sf ${pkgs.nodejs_18}/bin/node $i/node
      done
    '';
  };
}
