{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.dev.desktop.hyprland.enable {
  home.packages = with pkgs; [
    kitty
	google-chrome
	telegram-desktop
	discord
	blender
	godot	
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";

      monitor = ",preferred,auto,1";

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "NVD_BACKEND,direct"
      ];

      input = {
        kb_layout = "us,ua";
        kb_options = "grp:alt_shift_toggle";
      };

      general = {
        border_size = 2;
        "col.active_border" = "rgba(b7bdf8ff)";
        "col.inactive_border" = "rgba(6e738dff)";
      };

      decoration = {
        rounding = 8;
      };

      exec-once = [
        "noctalia-shell"
      ];

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, D, exec, $menu"
        "$mod, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, F, fullscreen"
        "$mod, Space, togglefloating"

        # focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
