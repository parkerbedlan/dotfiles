{ ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "screen-256color";
    extraConfig = ''
      set -g status-bg "white"
      # may need slight modification? google it if it seems to not be working
      set-option -sa terminal-overrides ",xterm-256color:RGB"
      # probably redundant, but uncomment if stuff is acting weird
      # setw -g pane-base-index 1
    '';
  };
}
