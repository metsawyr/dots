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
    pkgs.vulkan-tools # vkcube, vulkaninfo
    pkgs.vulkan-loader
    pkgs.vulkan-validation-layers
    pkgs.mesa-demos # glxgears sanity check
  ];

  wsl = {
    enable = true;
    defaultUser = user;
    # Symlink Windows GPU driver into /usr/lib/wsl -> hw-accel GL/Vulkan via WSLg.
    useWindowsDriver = true;
  };

  # Enable graphics stack (Mesa + Vulkan loader).
  hardware.graphics.enable = true;

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
}
