{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [
  	inputs.nixos-wsl.nixosModules.wsl
	(fetchTarball {
		url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
		sha256 = "1rq8mrlmbzpcbv9ys0x88alw30ks70jlmvnfr2j8v830yy5wvw7h";
	})
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
