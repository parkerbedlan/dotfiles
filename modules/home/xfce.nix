{ ... }:
{
  home.file = {
    ".config/xfce4/terminal/accels.scm".text = ''
      (gtk_accel_path "<Actions>/terminal-window/paste" "<Primary>v")
      (gtk_accel_path "<Actions>/terminal-window/next-tab" "<Primary>Tab")
      (gtk_accel_path "<Actions>/terminal-window/prev-tab" "<Primary><Shift>ISO_Left_Tab")
    '';
    # https://github.com/catppuccin/xfce4-terminal
    ".local/share/xfce4/terminal/colorschemes/catppuccin-mocha.theme".text = ''
      [Scheme]
      Name=Catppuccin-Mocha
      ColorCursor=#f5e0dc
      ColorCursorForeground=#11111b
      ColorCursorUseDefault=FALSE
      ColorForeground=#cdd6f4
      ColorBackground=#1e1e2e
      ColorSelectionBackground=#585b70
      ColorSelection=#cdd6f4
      ColorSelectionUseDefault=FALSE
      TabActivityColor=#fab387
      ColorPalette=#45475a;#f38ba8;#a6e3a1;#f9e2af;#89b4fa;#f5c2e7;#94e2d5;#bac2de;#585b70;#f38ba8;#a6e3a1;#f9e2af;#89b4fa;#f5c2e7;#94e2d5;#a6adc8
    '';
  };

  xfconf.settings = {
    xfce4-terminal = {
      "misc-show-unsafe-paste-dialog" = false;
      # stylix didn't work for some reason so did it manually with https://github.com/catppuccin/xfce4-terminal
      "color-use-theme" = "Catppuccin-Mocha";
      "misc-maximize-default" = true;
    };
    xfce4-keyboard-shortcuts = {
      "commands/custom/<Super>1" = "wmctrl -s 0";
      "commands/custom/<Super>2" = "wmctrl -s 1";
      "commands/custom/<Super>3" = "wmctrl -s 2";
      "commands/custom/<Super>4" = "wmctrl -s 3";
      "commands/custom/<Super>5" = "wmctrl -s 4";
      "commands/custom/<Super>6" = "wmctrl -s 5";
      "commands/custom/<Super>7" = "wmctrl -s 6";
      "commands/custom/<Super>8" = "wmctrl -s 7";
      "commands/custom/<Super>9" = "wmctrl -s 8";
      "commands/custom/<Super>0" = "wmctrl -s 9";
      "commands/custom/<Super><Alt>1" = "librewolf";
      "commands/custom/<Super><Alt>2" = "xfce4-terminal";
      "commands/custom/<Super><Alt>3" = "discord";
      "commands/custom/<Super><Alt>4" = "cursor";
      "commands/custom/<Super><Alt><Shift>3" = "whatsie";
      "commands/custom/<Super><Alt>5" = "obs";
      "commands/custom/<Super><Alt>7" = "spotify";
      "commands/custom/<Super>F" = "xfce4-appfinder";
    };
    xfwm4 = {
      "general/workspace_count" = 10;
      "general/workspace_names" = [
        "Browser"
        "Terminal"
        "Messaging"
        "Dev Tools"
        "Video Call"
        "Workspace 6"
        "Music"
        "Workspace 8"
        "Workspace 9"
        "Gamer"
      ];
      "general/activate_action" = "switch";
      "general/easy_click" = "none";
    };
    # sadly this doesn't work for some reason, so I'm doing it through the cli in my startup script
    # xfce4-panel = {
    #   "/plugins/plugin-6/hidden-legacy-items" = [ "parcellite" ];
    # };
  };
}
