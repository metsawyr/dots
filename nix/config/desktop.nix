{
  pkgs,
  user,
  ...
}: {
  programs.hyprland.enable = true;
  xdg.portal.enable = true;

  hardware.graphics.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts.packages = [pkgs.nerd-fonts.inconsolata];

  # No greeter: autologin on TTY, exec Hyprland on tty1.
  services.getty.autologinUser = user;
  programs.zsh.loginShellInit = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
  '';
}
