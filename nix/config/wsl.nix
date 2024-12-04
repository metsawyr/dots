{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [
	inputs.nixos-wsl.nixosModules.wsl
	inputs.vscode-server.nixosModules.defaut
  ];

  environment.systemPackages = [
    (import ./win32yank.nix {inherit pkgs;})
  ];

  wsl = {
    enable = true;
    defaultUser = user;
  };

  services.vscode-server.enable = true;
}
