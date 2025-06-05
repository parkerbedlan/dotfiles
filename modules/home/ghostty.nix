{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      font-size = 18;
      # https://ghostty.org/docs/config/keybind/reference
      keybind = [
        "ctrl+v=paste_from_clipboard"
      ];
      maximize = true;
    };
  };
}
