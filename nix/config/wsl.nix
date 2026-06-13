{
  pkgs,
  lib,
  inputs,
  user,
  ...
}: {
  imports = [
	inputs.nixos-wsl.nixosModules.wsl
	inputs.vscode-server.nixosModules.default
  ];

  # nixos-wsl-utils Cargo.lock pins clap needing edition2024 (cargo >=1.85),
  # but nixpkgs 24.11 ships cargo 1.82. Build it with unstable's rust toolchain.
  system.build.nativeUtils = lib.mkForce (
    pkgs.callPackage "${inputs.nixos-wsl}/utils" {
      rustPlatform =
        inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.rustPlatform;
    }
  );

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

  # dzn (Vulkan-over-D3D12) dlopens libdxcore.so by soname, but the WSL driver
  # dir isn't in the default ld path -> vkCreateInstance returns -3 and Vulkan
  # falls back to llvmpipe. Put the driver dir on the loader path.
  environment.sessionVariables.LD_LIBRARY_PATH = ["/run/opengl-driver/lib"];

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
}
