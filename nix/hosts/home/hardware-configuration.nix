# PLACEHOLDER — regenerate on the real machine:
#   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
# The values below are minimal stubs so the flake evaluates; replace before install.
{...}: {
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod"];
  boot.kernelModules = ["kvm-intel"];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
