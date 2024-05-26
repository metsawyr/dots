{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    aggressiveResize = true;
    baseIndex = 1;
    prefix = "M-w";
    escapeTime = 10;

    plugins = with pkgs.tmuxPlugins; [
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }

      {
        plugin = catppuccin;
        extraConfig = ''
                set -g @catppuccin_flavour 'macchiato'

                set -g @catppuccin_window_status_enable 'yes'
          set -g @catppuccin_window_left_separator ""
             set -g @catppuccin_window_right_separator " "
             set -g @catppuccin_window_middle_separator " █"
             set -g @catppuccin_window_number_position "right"
             set -g @catppuccin_window_default_fill "number"
             set -g @catppuccin_window_default_text "#{b:pane_current_path}"
             set -g @catppuccin_window_current_fill "number"

             set -g @catppuccin_status_modules_right "directory meetings date_time"
             set -g @catppuccin_status_modules_left "session"
             set -g @catppuccin_status_left_separator  " "
             set -g @catppuccin_status_right_separator " "
             set -g @catppuccin_status_right_separator_inverse "no"
             set -g @catppuccin_status_fill "icon"
             set -g @catppuccin_status_connect_separator "no"

             set -g @catppuccin_directory_text "#{b:pane_current_path}"
        '';
      }
    ];

    terminal = "tmux-256color";
    extraConfig = ''
         set -as terminal-features ',xterm-256color:RGB'

      set -g mouse on
      set -g status-position top
      set -g renumber-windows on

      bind w list-windows
         bind z resize-pane -Z

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
         bind H previous-window
         bind L next-window
      bind M-v split-window -v -c "#{pane_current_path}"
         bind M-h split-window -h -c "#{pane_current_path}"

    '';
  };
}
