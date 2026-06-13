{
  pkgs,
  user,
  ...
}: {
  # Hyprland session + xdg portals.
  programs.hyprland.enable = true;
  xdg.portal.enable = true;

  hardware.graphics.enable = true;

  # VM-friendly: let wlroots fall back to software rendering (llvmpipe) and
  # avoid hardware cursor planes the virtual GPU may not support.
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts.packages = [
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # No greeter: autologin on TTY, exec Hyprland on tty1.
  services.getty.autologinUser = user;
  programs.zsh.loginShellInit = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
  '';
}
