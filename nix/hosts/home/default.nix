{
  user,
  ...
}: {
  imports = [
    ../../config/desktop.nix
    ./hardware-configuration.nix
  ];

  # Adjust on real hardware (systemd-boot assumes UEFI).
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  # isNormalUser/shell/zsh come from config/nix.nix; only add desktop groups.
  users.users.${user}.extraGroups = ["wheel" "video" "input" "audio"];
}
