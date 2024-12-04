{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [
	inputs.nixos-wsl.nixosModules.wsl
	inputs.vscode-server.nixosModules.default
  ];

  environment.systemPackages = [
    (import ./win32yank.nix {inherit pkgs;})
  ];

  wsl = {
    enable = true;
    defaultUser = user;
  };

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
}
