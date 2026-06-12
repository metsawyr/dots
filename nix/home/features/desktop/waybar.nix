{
  lib,
  config,
  ...
}:
lib.mkIf config.dev.desktop.hyprland.enable {
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;

      modules-left = ["hyprland/workspaces"];
      modules-center = ["clock"];
      modules-right = ["pulseaudio" "network" "cpu" "memory" "tray"];

      clock.format = "{:%a %d %b  %H:%M}";
      cpu.format = " {usage}%";
      memory.format = " {}%";
      network.format = " {essid}";
      pulseaudio.format = " {volume}%";
    };
  };
}
