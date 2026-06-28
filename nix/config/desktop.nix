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

  hardware.opengl = {
    enable = true;
	driSupport32Bit = true;
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
  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";

  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
}
