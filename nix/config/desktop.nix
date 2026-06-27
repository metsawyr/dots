{
  config,
  pkgs,
  user,
  ...
}: {
  programs.hyprland.enable = true;
  xdg.portal.enable = true;

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts.packages = [pkgs.nerd-fonts.inconsolata];

  services.getty.autologinUser = user;
  programs.zsh.loginShellInit = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      start-hyprland
    fi
  '';

  networking.networkmanager.enable = true;  
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;
}
